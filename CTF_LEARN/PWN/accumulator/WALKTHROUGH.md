# accumulator - PWN (Integer Overflow)

**Flag:** `CTFlearn{n3x7_7yp3_0f_0v3rf0w}`

## Analisi
Il programma somma numeri in `int acc` finche' `acc >= 0`, e rifiuta i numeri negativi. Alla fine del loop fa `system("cat ./flag.txt")`. Sembra impossibile uscire dal loop... ma `int` e' a 32 bit con segno (max `2147483647`): sommando valori positivi grandi si va in **overflow** e `acc` diventa negativo.

## Soluzione - passo per passo
> Se manca il binario `task`, compilalo: `gcc task.c -o task`

1. Entra nella cartella:
   ```
   cd accumulator
   ```
2. Inserisci due volte `2000000000`:
   ```
   printf '2000000000\n2000000000\n' | ./task
   ```
   `2000000000 + 2000000000 = 4000000000` > 2^31-1 --> `acc` diventa negativo --> esce dal loop.
3. Output finale:
   ```
   You win! acc = -294967296
   CTFlearn{n3x7\_7yp3\_0f\_0v3rf0w}
   ```

