# PikesPeak - Stego (flag vera tra i depistaggi)

**Flag (vera):** `CTFLEARN{PikesPeak}`

## Analisi
Il JPEG contiene **molti** commenti, quasi tutti depistaggi (`CTFLearn{Colorado}`, `ctflearn{MountainMountainMountain}`, `CTF{AsPEN.Vail}`, `CTFlearn{Gandalf}`, ...). La flag giusta e' quella che corrisponde al nome della challenge ("Pike's Peak") --> `CTFLEARN{PikesPeak}`.

## Soluzione - passo per passo
1. Entra nella cartella:
   ```
   cd pikespeak
   ```
2. Elenca tutte le stringhe candidate:
   ```
   strings PikesPeak.jpg | grep -iE 'ctf(learn)?\{'
   ```
   Escono vari candidati; quello corretto e':
   ```
   CTFLEARN{PikesPeak}
   ```

Oppure con exiftool per vedere i commenti:
```
exiftool PikesPeak.jpg
```


