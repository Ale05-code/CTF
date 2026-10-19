## SS_0.01

1. Faccio: strings the_safe --> vedo che c'è una password in chiaro 
2. chmod +x the_safe --> rendo eseguibile il file  
3. ./the_safe 
4. Mi chiede la password: you\_cAnT\_gue55\_th1z\_s3cur3\_p@ssword
5. CCIT{d0nT-u5e-plA1nt3xT}


## SS_0.02 

1. objdump -d acrostic --> vedo che le inziali delle funzioni formano la frase "thelastofus"
2. CCIT{thelastofus}


## SS_0.03 

1. objdump -d dissection 
2. vedo che ogni tanto ce la flag scomposta tra l'assembly del binario 
3. CCIT{I\_c\_d3ad\_secti0n5}

## SS_0.04 

1. Con: strings volatility  

- **Funzione `decode_flag`**: Crea la flag in memoria partendo da dati offuscati.
    
- **Funzione `clear_flag`**: Cancella la flag subito dopo averla creata (la rende "volatile").

2. chmod +x volatility 
3. gdb ./volatility 
4. break clear_flag 
5. run 
6. CCIT{Br3akp0ints\_R\_u5efuL}

## SS_0.05 

1. Ci si connette con nc e is vede che vengono fatte delle domande (conversioni/rgihe vuote) che son sempre le stesse 
2. Faccio uno script che mi automatizza tutto
3. CCIT{Ye5\_U\_couLd\_G3T\_tH3\_Fl49\_bY\_hanD\_bUT\_5cRipT1ng\_15\_THE\_w4y\_2\_g0}
