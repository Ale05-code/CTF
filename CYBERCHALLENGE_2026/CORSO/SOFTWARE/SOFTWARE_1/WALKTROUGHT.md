## **SS_1.01**

1. Faccio   file nextgen\_safe --> vedo che è un eseguibile 
2. chmod +x ./nextgen\_safe 
3. ./nextgensafe    vedo che mi chiede una password e se tu ne metti una sbagliata si interrompe 
4. strings nextgen\_safe --> vedo nome di una funzione "strana" --> print\_safe\_contents 
5. Avvio gdb con gdb ./nextgen_safe 
6. info functions --> vedo che la funzione non viene chiamata nel main 
7. break main --> metto un breakpoint nel main 
8. run 
9. Quando si interrompe faccio --> jump print\_safe\_contents 
10. CCIT{gdb\_t0\_th3\_re5cue}

## **SS_1.02** 

1. stringa ./slowprinter --> mostra la funzione "usleep" che ha il compito di mettere a dormire un operazione prima di effettuarla (in questo caso la print della flag) in maniera esponenziale 
2. gdb ./slowprinter 
3. break usleep 

    Se dopo provo a fare run --> return (per ritornare il valore della funzione --> flag) non mi succede nulla perché chiude solo la chiamata alla funzione corrente e non tutte quelle che servono per stampare la flag 
    
    Io so però che gli argomenti di una funzione vengono salvati in dei registri sempre allo stesso modo: 
    
    1. Primo argomento: rdi 
    2. Secondo argomento: rsi 
    3. Terzo argomento: rdx 
    4. Quarto argomento: rcx 
    5. Quinto argomento: r8 
    6. Sesto argomento: r9 
    
    La funzione ha solo 1 argomento (il timer) --> quando la chiamo, l argomento viene salvato sempre in rdi. Quindi se io "imposto" il timer a 0 mi stampa subito la flag --> uso i registri visti adesso 
    
4. commands         --> quando si ferma esegue una lista di comandi che setto io 
    set $rdi = 0    --> setto il timer a 0 
    continue        --> fa questa cosa per ogni chiamata 
    end 
    
5. run 
6. mi stampa la flag CCIT{tim3\_flie5\_WiTh\_s0m3\_heLp}


## **SS_1.03** 

1. strings flag\_checker --> ha rivelato dove potrebbe stare la flag con la frase "Well done: your flag is ..." 

2. Messo il file su ghidra e analizzando il main ci si è resti conto della funzione FUN_00101169 che esegue una banale somme e controllo: 

if (param\_3 == *param\_2) {
    local\_18 = param\_2 + 1;
    local\_10 = param\_1 + 1;
    FUN_00101169(local\_10,local\_18,param\_3);
}


- **`param\_3`**: Rappresentava la somma dei caratteri che veniva inseriti da terminale
- **`*param\_2`**: Rappresentava il valore salvato nel binario all'indirizzo `0x104020`.

2. objdump -s -j .data ./flag\_checker ---> per estrarre i byte in hex salvati nella sezione dati del programma --> serve per trovare i numeri della somma progressiva 

3. Alla sezione 0x104020 abbiamo trovato: 
- Traguardo 1: `0x54` (84)
- Traguardo 2: `0xc3` (195)
- Traguardo 3: `0x122` (290)
- ...e così via.

Il programma, mentre viene scritta la flag, tiene il conto così:

- Prende la 1ª lettera $\rightarrow$ deve essere uguale al Traguardo 1.
- Prende la 1ª + 2ª lettera $\rightarrow$ la somma deve essere uguale al Traguardo 2.
- Prende la 1ª + 2ª + 3ª lettera $\rightarrow$ la somma deve essere uguale al Traguardo 3.
    

Per scoprire le lettere singole, abbiamo dovuto fare il calcolo all'indietro:

- -La 1ª lettera è **84** ('T').
- La 2ª lettera è **195 - 84 = 111** ('o').
- La 3ª lettera è **290 - 195 = 95** ('$\_$').
- La 4ª lettera è **395 - 290 = 105** ('i').


4. CCIT{To\_iTer4te\_i5\_hUmaN\_t0\_r3CuRse\_d1vine}

## **SS_1.04**

1. strings unbreakbale_aes --> vedo che ce un funzione encrypt 
2. Metto il fil su ghidra e se vado nel main --> cerco la funzione encrypt che al suo interno contiene l'operazione ror (rotate right) 
3. La funzione ror esegue una rotazione bit a bit spostando i bit in modo circolare. Ad esempio il byte 1: lo ruota di 1 bit a destra, il byte 2: ruota di 2 bit a destra. 
4. L'opposto di ror e rol (rotate left)
5. Visto che la rotazione avviene su un byte (8bit) ruote di n posizioni è lo stesso che ruotare di n (mod 8)
6. Scritto script in python che ha il compito di leggere i bit dal file .aes, applicare la funzione rol per ogni byte e ricostruire la flag
7. CCIT{n0t\_re4llY\_using\_K}
