# Reykjavik - Reversing (anti false-flag)

**Flag:** `CTFlearn{Eye_L0ve_Iceland_}`
(la *false flag* visibile con `strings` e' `CTFlearn{Is_This_A_False_Flag?}` - e' un depistaggio)

## File
- `Reykjavik` - binario ELF a 64 bit, non stripped
- `readme` - introduzione

## Analisi
Uso: `Reykjavik CTFlearn{flag}`. Il binario genera/decifra la flag vera a runtime e la confronta con l'argomento tramite `strcmp`. In chiaro con `strings` si vede solo la flag falsa. Il modo piu' rapido: intercettare la `strcmp` con `ltrace`, che mostra i due operandi --> uno e' la flag vera.

## Soluzione - passo per passo
1. Entra nella cartella e rendi eseguibile il binario:
   ```
   cd reykjavik
   chmod +x Reykjavik
   ```
2. Lancia sotto `ltrace` con un argomento qualsiasi e filtra la `strcmp`:
   ```
   ltrace -s 200 ./Reykjavik 'CTFlearn{AAAA}' 2>&1 | grep strcmp
   ```
   Output:
   ```
   strcmp("CTFlearn{Eye_L0ve_Iceland_}", "CTFlearn{AAAA}") = 4
   ```
   Il primo operando e' la flag vera.
3. Verifica:
   ```
   ./Reykjavik 'CTFlearn{Eye_L0ve_Iceland_}'
   ```
   Output --> `Congratulations, you found the flag!!: 'CTFlearn{Eye_L0ve_Iceland_}'`


