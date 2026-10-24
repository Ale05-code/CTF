# PurpleThing - Stego (PNG dentro PNG)

**Flag:** `ABCTF{b1nw4lk_is_us3ful}`

## Analisi
`PurpleThing.jpeg` in realta' e' un **PNG** (780x720). Dentro, a partire dall'offset `153493` (`0x25795`), c'e' un **secondo PNG** (802x118) che contiene la flag scritta come testo.

## Soluzione - passo per passo
1. Entra nella cartella:
   ```
   cd purplething
   ```
2. Trova gli oggetti incorporati:
   ```
   binwalk PurpleThing.jpeg
   ```
   Mostra un PNG all'offset 0 e un **secondo PNG a 153493**.
3. Estrai il PNG nascosto:
   ```
   dd if=PurpleThing.jpeg of=flag.png bs=1 skip=153493
   ```
4. Apri `flag.png` con un visualizzatore di immagini:
   ```
   xdg-open flag.png
   ```
   Nell'immagine (802x118) e' scritto --> `ABCTF{b1nw4lk_is_us3ful}`


