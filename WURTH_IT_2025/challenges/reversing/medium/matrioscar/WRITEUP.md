# Matrioscar - Writeup

**CTF:** WPCTF 2025
**Categoria:** Reversing (medium)
**Flag:** `WPCTF{Bu7_Wh0_i5_7h1s_5o_c4lL3d_0sc4r?}`

## La challenge

> During a penetration test [...] a service that advertises "OSCO Protocol, Admin
> Access ONLY". Connecting shows a banner and prompt - but any plain-text input
> immediately crashes the process. It looks like the program expects a tightly-formatted,
> encoded/encrypted payload instead of normal commands. [...] Reverse the binary's input
> handling, craft a valid payload, and make the service accept it to reveal the secret shell.

Ci viene dato un binario (compilato da Python + una libreria Rust) che:
1. stampa un banner,
2. legge una riga dal prompt `~>`,
3. la fa passare attraverso **una lunga catena di trasformazioni** (crittografiche e non),
4. ed esegue il risultato come **comando di shell**.

Il nome "**matrioscar**" è il primo indizio: come una **matrioska**, il nostro input viene
infilato dentro strato su strato di trasformazioni. Per risolverla dobbiamo *svestire* le
bambole al contrario: capire la catena, invertirla, e far uscire dall'altra parte un comando
che ci legga la flag.

## 1. L'architettura: Python che chiama Rust

La challenge è in due pezzi:

- `matrioscar_py/main.py` --> la **logica di alto livello**: definisce *l'ordine* delle operazioni.
- `src/lib.rs` --> le **15 funzioni** vere e proprie, scritte in Rust ed esposte a Python via `pyo3`.

Le funzioni hanno nomi "scientifici" casuali (`fervent_ramanujan`, `elated_liskov`, …) per
confondere, ma ogni commento nel Rust rivela cosa fanno davvero.

## 2. L'obiettivo: `jovial_babbage` esegue una shell

La chiave di tutto è l'ultima riga di `main()`:

```python
print(jovial_babbage(user_input), end="")
```

e la funzione corrispondente in Rust:

```rust
fn jovial_babbage(input: &[u8]) -> String {
    let command = std::str::from_utf8(input).unwrap_or_default();
    let output = Command::new("sh").arg("-c").arg(command).output();  // sh -c "<input>"
    match output {
        Err(_) => String::new(),
        Ok(output) => String::from_utf8_lossy(&output.stdout).to_string(),  // stampa solo STDOUT
    }
}
```

**Il problema si capovolge:** non dobbiamo *decifrare* niente. Dobbiamo trovare **cosa digitare
al prompt** in modo che, dopo tutta la catena, esca una stringa di shell valida tipo
`cat /flag.txt` (il Dockerfile mette la flag in `/flag.txt`).

Due dettagli preziosi di questa funzione, che useremo dopo:
- esegue `sh -c`, quindi vale la sintassi di shell (`;`, `||`, `#`, a capo…);
- stampa **solo lo stdout** --> tutto ciò che va su **stderr** (es. errori "command not found") viene **scartato**.

## 3. La pipeline completa

Mettendo in fila `main.py`, l'input attraversa (in ordine):

| #  | funzione              | cosa fa (dal commento Rust)        |
|----|-----------------------|------------------------------------|
| 1  | `fervent_ramanujan`   | hex **decode**                     |
| 2  | `diligent_tesla`      | cifrario di Cesare −5              |
| 3  | `elated_liskov`       | **AES-128-CBC decrypt**            |
| 4  | `clever_turing`       | nibble swap (scambia i 4 bit alti/bassi) |
| 5  | `thirsty_leakey`      | XOR con `awesome_easley`           |
| 6  | `interesting_agnesi`  | NOP (non fa niente)                |
| 7  | `gifted_brahmagupta`  | NOT sui byte di indice dispari     |
| 8  | **blocco `ord`**      | sequenza variabile di funzioni     |
| 9  | `frosty_shannon`      | rot13                              |
| 10 | `pensive_engelbart`   | `b − 51` (mod 256)                 |
| 11 | `youthful_dhawan`     | reverse (inverte i byte)           |
| 12 | `fervent_ramanujan`   | hex **decode**                     |
| 13 | `zealous_visvesvaraya`| NOT bit a bit                      |
| 14 | `flamboyant_shannon`  | base64 **decode**                  |
| 15 | `tender_dijkstra`     | aggiunge prefisso + suffisso       |
| -->  | `jovial_babbage`      | `sh -c` sul risultato              |

Per invertire parto dall'**ultima** e risalgo: come svestire le matrioske, l'ultima infilata
è la prima da togliere.

## 4. Il blocco variabile: un finto-random deterministico

Lo step #8 è particolare:

```python
ord: list[int] = meticulous_einstein(len(FUNCTIONS))  # len = 13
...
for idx in ord:
    user_input = FUNCTIONS[idx](user_input)
```

Applica una **sequenza** di funzioni il cui ordine è deciso dalla lista `ord`. Il commento Rust
dice "pseudorandom", ma guardiamolo bene:

```rust
fn meticulous_einstein(input: u8) -> Vec<u8> {
    let current_date = chrono::Utc::now();
    let seed = b"thirsty_murdock";              // FISSO
    let length = current_date.day() % 10 + 15;  // dipende dal GIORNO del mese

    let mut out = Vec::with_capacity(length as usize);
    let mut ctr: u32 = 0;
    while out.len() < length as usize {
        let mut hasher = Sha256::new();
        hasher.update(seed);
        hasher.update(ctr.to_le_bytes());        // ctr come 4 byte little-endian
        let digest = hasher.finalize();
        for &b in digest.iter() {
            out.push(b % (input));               // input = 13 = len(FUNCTIONS)
            if out.len() == length as usize { break; }
        }
        ctr += 1;
    }
    out
}
```

**Considerazione chiave:** l'unica cosa al mondo che cambia è il **giorno del mese** (`.day()`),
che fissa solo la *lunghezza* della lista (da 15 a 24). Seed, contatore e modulo (13) sono
costanti. Quindi la lista `ord` **non è imprevedibile**: sapendo la data, la ricalcoliamo
identica a quella del server. Non è un "random", è un PRNG con sequenza predeterminata.

Riproduciamolo in Python:

```python
def gen_ord(day):
    seed = b"thirsty_murdock"
    length = day % 10 + 15
    out, ctr = [], 0
    while len(out) < length:
        h = hashlib.sha256()
        h.update(seed)
        h.update(ctr.to_bytes(4, "little"))   # ctr.to_le_bytes() del Rust
        for b in h.digest():
            out.append(b % 13)
            if len(out) == length:
                break
        ctr += 1
    return out
```

Per il giorno 13 --> lunghezza 18 --> `ord = [12, 4, 5, 2, 1, 8, 10, 8, 12, 5, 1, 0, 8, 12, 10, 3, 6, 0]`.

Gli indici mappano sulla lista `FUNCTIONS` del `main.py` (0–12).

### Come nasce la lista `ord`

La lista si costruisce in tre passaggi distinti. Conviene separarli, perché il numero **13**
compare con due significati diversi: una volta come **giorno del mese**, una volta come **numero
di funzioni disponibili** (`len(FUNCTIONS)`).

**Passo 1 - quanti numeri servono.** La lunghezza dipende solo dal giorno:

```
length = day % 10 + 15   -->   13 % 10 + 15 = 18
```

Oggi (giorno 13) la lista avrà quindi **18** elementi. Questo è l'unico punto in cui entra in
gioco la data.

**Passo 2 - da dove vengono i valori.** I numeri li produce **SHA256**, applicato alla stringa
fissa `seed` concatenata a un contatore. L'hash restituisce 32 byte; presi in decimale, i primi
sono:

```
SHA256(b"thirsty_murdock" + 0x00000000)
-->  12, 173, 148, 184, 209, 164, 218, 73, 168, 213, 170, 221, 34, 64, 153, 172, 84, 39, ...
```

Essendo SHA256 deterministico, con lo stesso input produce sempre questa identica sequenza: è
qui che risiede la prevedibilità della challenge.

**Passo 3 - ridurre i byte a indici validi.** Ogni byte vale 0–255, ma gli indici delle funzioni vanno da 0 a 12. Si applica quindi `% 13` (dove 13 = `len(FUNCTIONS)`):

| byte del digest | `% 13` --> indice |
|---|---|
| 12  | 12 |
| 173 | 4  |
| 148 | 5  |
| 184 | 2  |
| 209 | 1  |
| …   | …  |

Tenendo i primi 18 valori:

```
ord = [12, 4, 5, 2, 1, 8, 10, 8, 12, 5, 1, 0, 8, 12, 10, 3, 6, 0]
```

In sintesi: i valori nascono dall'hash SHA256 di una stringa fissa, il giorno del mese ne
determina la quantità, e il modulo 13 li mappa sugli indici delle funzioni.

> Il **contatore** entra in gioco solo quando servono più di 32 byte (la dimensione di un
> digest): in quel caso si rigenera `SHA256(seed + 1)`, `SHA256(seed + 2)`… accodando altri
> byte. Con 18 elementi è sufficiente il primo digest.

## 5. Il trucco del wrapper (`tender_dijkstra`)

L'ultimo step prima dell'esecuzione aggiunge un prefisso e un suffisso **fissi**:

```rust
let prefix = b"gallant_wing-";
let suffix = b"-xenodochial_shockley";
// output = prefix + input + suffix
```

Conseguenza fondamentale: la stringa che `sh -c` riceve è **obbligatoriamente**

```
gallant_wing-<ROBA CHE CONTROLLO IO>-xenodochial_shockley
```

Non posso togliere prefisso/suffisso dalla stringa eseguita - posso solo scegliere cosa c'è in
mezzo. Quindi devo scrivere il "mezzo" in modo che il tutto resti un comando valido che esegue
*solo* ciò che voglio io. Due modi equivalenti (abbiamo usato il primo):

**Opzione A - a capo + commento:**
```
mezzo = "\ncat /flag.txt #"
-->  gallant_wing-\ncat /flag.txt #-xenodochial_shockley
   riga 1: gallant_wing-        --> command not found (va su STDERR, scartato)
   riga 2: cat /flag.txt #...    --> gira; il # commenta il suffisso
```

**Opzione B - operatori di shell** (quella del solver ufficiale):
```
mezzo = "||cat /flag.txt;"
-->  gallant_wing-||cat /flag.txt;-xenodochial_shockley
   gallant_wing-  fallisce  -->  "||"  esegue il comando dopo  -->  cat /flag.txt
   ";" chiude; -xenodochial_shockley fallisce (innocuo)
```

In entrambi i casi sfruttiamo il fatto che `jovial_babbage` stampa solo lo **stdout**: gli
errori dei pezzi "spazzatura" (prefisso/suffisso) spariscono.

## 6. Invertire la catena

Regola generale: **le operazioni si annullano in ordine inverso**, e per
ciascuna applico la sua funzione opposta. Molte funzioni qui sono **auto-inverse** (applicarle
due volte torna al punto di partenza): è un regalo.

| funzione (avanti)      | operazione   | inversa che applico io      | auto-inversa? |
|------------------------|--------------|-----------------------------|:-------------:|
| `fervent_ramanujan`    | hex decode   | hex **encode**              |               |
| `diligent_tesla`       | Cesare −5    | Cesare **+5**               |               |
| `elated_liskov`        | AES decrypt  | AES **encrypt** (stessa key/IV) |           |
| `clever_turing`        | nibble swap  | nibble swap                 | SI            |
| `thirsty_leakey`       | XOR          | stesso XOR                  | SI            |
| `interesting_agnesi`   | NOP          | NOP                         | SI            |
| `gifted_brahmagupta`   | NOT dispari  | stessa                      | SI            |
| `frosty_shannon`       | rot13        | rot13                       | SI            |
| `pensive_engelbart`    | −51          | **+51**                     |               |
| `youthful_dhawan`      | reverse      | reverse                     | SI            |
| `zealous_visvesvaraya` | NOT          | NOT                         | SI            |
| `flamboyant_shannon`   | base64 dec   | base64 **encode**           |               |

**Perché costruire a ritroso con gli *encode* è importante.** Alcuni step sono dei *decode*
(hex, base64, AES). In Rust, se un decode riceve dati non validi, fa `unwrap_or_default()` -->
restituisce **vuoto**, e tutta la catena collassa. Costruendo il payload all'indietro con gli
*encode*, produciamo sempre dati che il decode in avanti accetterà di sicuro (es. un hex-encode
genera solo `0-9a-f`, hex valido al 100%). Così evitiamo che la pipeline si "svuoti".

Per il **blocco `ord`**: in avanti applica `ord[0] … ord[17]`, quindi a ritroso applico le
inverse in ordine **capovolto**: `inv(ord[17]) … inv(ord[0])`.

## 7. Lo script

La soluzione completa e commentata è in [`exploit.py`](exploit.py). Il cuore è la risalita,
che parte dal valore che deve uscire dallo strato base64 (il nostro "mezzo") e applica le
inverse dall'ultimo strato al primo:

```python
X = b"\ncat /flag.txt #"            # il comando da far arrivare a sh -c

d = X
d = i_b64dec(d)                     # inv #14 flamboyant_shannon (base64 encode)
d = f_not(d)                        # inv #13 zealous_visvesvaraya
d = i_hexdec(d)                     # inv #12 fervent_ramanujan   (hex encode)
d = f_reverse(d)                    # inv #11 youthful_dhawan
d = sub_inv(d)                      # inv #10 pensive_engelbart   (+51)
d = f_rot13(d)                      # inv #9  frosty_shannon
for idx in reversed(order):         # inv #8  blocco ord (ordine capovolto)
    d = FUNCS[idx][1](d)
d = f_flipalt(d)                    # inv #7  gifted_brahmagupta
d = f_nop(d)                        # inv #6  interesting_agnesi
d = f_xor(d)                        # inv #5  thirsty_leakey
d = f_nibble(d)                     # inv #4  clever_turing
d = i_aesdec(d)                     # inv #3  elated_liskov       (AES encrypt)
d = i_caesar5(d)                    # inv #2  diligent_tesla      (+5)
d = i_hexdec(d)                     # inv #1  fervent_ramanujan   (hex encode)
payload = d
```

**Verifica end-to-end.** Prima di fidarci, rifacciamo la catena *in avanti* partendo dal payload
e controlliamo di tornare esattamente a `X`. Se l'`assert` non scatta, il payload è
matematicamente corretto senza nemmeno toccare il server:

```python
assert forward(payload) == X
```

## 8. Lanciarlo

```bash
# contro il server vero della CTF:
python3 exploit.py <host> 27381

# oppure in locale (serve il binario e un flag.txt):
echo 'WPCTF{...}' > flag.txt
bash build.sh
socat TCP-LISTEN:27381,reuseaddr,fork EXEC:./matrioscar &
python3 exploit.py 127.0.0.1 27381
```

Risultato:

```
~>
WPCTF{Bu7_Wh0_i5_7h1s_5o_c4lL3d_0sc4r?}
```

> Il payload **cambia ogni giorno**: la lista `ord` dipende dal giorno del mese (UTC), quindi
> `exploit.py` la rigenera a ogni esecuzione. Non riusare un payload salvato il giorno prima.

## Cosa ho imparato

- Quando l'ultimo step esegue `sh -c`, la challenge non è "decifrare" ma **costruire a ritroso**
  un input che diventi un comando.
- Un prefisso/suffisso incollato al comando si neutralizza con i **trucchi di shell**
  (a capo + `#`, oppure `||` … `;`), sfruttando il fatto che **stderr viene scartato**.
- Un "random basato su seed fisso + data" **non è random**: è deterministico e ricalcolabile.
- `ctr.to_le_bytes()` in Rust = `ctr.to_bytes(4, "little")` in Python (u32 --> 4 byte little-endian).
- Le operazioni si invertono **in ordine inverso**; molte (NOT, reverse, rot13, XOR, nibble swap)
  sono **auto-inverse**.
- L'inversa di un *decode* è un *encode*: costruire a ritroso con gli encode garantisce che i
  decode in avanti **non falliscano** (evita il `unwrap_or_default()` che svuota tutto).
- Invertire AES-CBC = cifrare con la **stessa chiave e lo stesso IV** (entrambi in chiaro nel codice).
- **Verificare** il payload rifacendo la pipeline in avanti dà la certezza di correttezza prima
  ancora di connettersi al server.
```
