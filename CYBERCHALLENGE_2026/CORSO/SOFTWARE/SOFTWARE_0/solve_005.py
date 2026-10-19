from pwn import * 
import re 

r = remote('piecewise.challs.cyberchallenge.it', 9110) 

last_full_message= ""

while True: 
    try: 
        chunk = r.recvline().decode(errors='ignore') # ignora tutti i caratteri non mappali 
        context.log_level = 'debug'     # per vedere cosa stampa byte pe rbyte 
        if not chunk: break 
        
        last_full_message= chunk 
        
        if "byte 10" in chunk: 
            r.send(b"\n")
            
        match = re.search(r'number (\d+)', chunk) 
        if match: 
            numero = int(match.group(1))
            bits = 64 if "64-bit" in chunk else 32 
            endian = 'little' if "little-endian" in chunk else 'big' 
            
            if bits == 32: 
                r.send(p32(numero, endian=endian))
            else: 
                r.send(p64(numero, endian=endian)) 
        if "CCIT{" in chunk: 
            res = re.findall(r'CCIT{.*?\}', chunk) 
            if res: 
                print(f"    FLAG: {res}")
    except EOFError: 
        print("\n Errore") 
        break 

r.interactive()
