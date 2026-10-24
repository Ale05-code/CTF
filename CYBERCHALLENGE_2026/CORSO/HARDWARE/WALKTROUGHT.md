**HW_1.01**

L'obiettivo è di trovare un trojan hardware. E' composto sempre da due parti: 
1. trigger: condizione che llo attiva  --> sequeza di segnali 
2. payload: effetto malevolo che scatena qwuando è soddisfatto il trigger 

Nel file **PROGRAMMABLE\_SAMPLER\_TOP** ci soon 3 contatori: 
1. 	signal TC\_COUNTER\_1\_MILLION : std\_logic;
2.	signal TC\_COUNTER\_60\_A : std\_logic;
2.	signal TC\_COUNTER\_60\_B : std\_logic;

Ci son anche delle entità: 
- DIN --> un singolo bit in ingresso
- CNTRL --> 8 bit
- SMPL --> l'uscita (un bit)
- più CLK e RST
Ed è fomrato da delle compinenit: 
- il registro a scorrimento (SHIFT_REGISTER) che memorizza gli ultimi bit entrati da dIN 
- il multiplexer scegliere, in base a CNTRL, quale di quei bit mandare in uscita a SMPL 
- tutto il resto è in più 

Ci sono due cose importantissime: 
1. Payload: il SYNC\_RST del SHIFT\_REGISTER è collegato a TC\_COUNTER\_60\_B. Quindi, quando quel contatore "scatta", azzera il registro a scorrimento, cioè cancella i campioni memorizzati. 
2. Uscita del SHIFT_REGISTER --> ingresso I del MULTIPLEXER --> SMPL.

Quindi il sabotaggio è che a un certo punto il trojan resetta il registro e il sampler smette di dare campioni validi. Ora dobbiamo capire cosa fa scattare TC\_COUNTER\_60\_B --> questo è il trigger.

Quindi la catena temporale è:
- il contatore da 1 milione fa "tic" ogni 1.000.000 di clock,
- COUNTER\_60\_B conta questi "tic" fino a 60,
- --> il payload (reset del registro) scatterebbe dopo circa 1.000.000 × 60 = 60.000.000 di colpi di clock.

MA, e qui sta i l punto cruciale, COUNTER\_60\_B conta solo finché not(TC\_COUNTER\_60\_A). Cioè COUNTER\_60\_A fa da interruttore/guardia:
- se TC\_COUNTER\_60\_A = 1 --> not(...) = 0 --> B bloccato --> trojan non scatta
- se TC\_COUNTER\_60\_A = 0 --> B conta --> trojan scatta (dopo i 60M clock)

CCIT{CNTRL[0]_1}
