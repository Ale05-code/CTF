def rol(n, d):
    # Ruota a sinistra un byte (8 bit)
    return ((n << (d % 8)) & 0xFF) | (n >> (8 - (d % 8)))

def decrypt():
    try:
        with open("flag.txt.aes", "rb") as f:
            ciphertext = f.read()
        
        plaintext = bytearray()
        
        for i, byte in enumerate(ciphertext):
            # Il contatore local_2c parte da 1 per il primo byte
            shift = i + 1
            # Invertiamo il ROR usando ROL
            decoded_byte = rol(byte, shift)
            plaintext.append(decoded_byte)
            
        print("Flag trovata:")
        print(plaintext.decode(errors="ignore"))
        
    except FileNotFoundError:
        print("Errore")

decrypt()
