# math - PWN (Aritmetica modulare 2^64)

**Flag:** `CTFlearn{ju5t_4_m0dul0_3qu4t10n}`
**Valore da inserire:** `9585860797856392871`

## Analisi
Il programma chiede `X` tale che `X * 212103456793011 == 183057226632645` in aritmetica `uint64_t` (cioe' modulo 2^64). Non e' una divisione reale: serve l'**inverso modulare** del moltiplicatore (esiste perche' e' dispari).

## Soluzione - passo per passo
1. Calcola `X`:
   ```
   python3 -c "print((183057226632645 * pow(212103456793011, -1, 2**64)) % 2**64)"
   ```
   Output --> `9585860797856392871`
2. Entra nella cartella e invia il valore:
   ```
   cd math
   echo 9585860797856392871 | ./task
   ```
3. Output --> `CTFlearn{ju5t_4_m0dul0_3qu4t10n}`


