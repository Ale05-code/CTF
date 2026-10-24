# positive_challenge - PWN (Short Integer Overflow)

**Flag:** `CTFlearn{n0t_s0_p0s1t1v3_4t_4ll}`

## Analisi
Come `accumulator` ma con `short` (16 bit). Ogni input viene reso positivo con `abs()`, poi `% 100`, e `acc = (acc + n) % 100`: `acc` dovrebbe restare in [0,99].

## Vulnerabilita'
`abs()` su un `short` di valore `-32768` (il minimo, `INT16_MIN`) non ha corrispondente positivo: `abs(-32768)` resta **-32768**. Quel valore poi rende `acc` negativo e si esce dal loop --> `system("cat ./flag.txt")`.

## Soluzione - passo per passo
> Se manca il binario `task`, compilalo: `gcc task.c -o task`

1. Entra nella cartella:
   ```
   cd positive_challenge
   ```
2. Inserisci `-32768`:
   ```
   printf -- '-32768\n' | ./task
   ```
3. Output --> `CTFlearn{n0t_s0_p0s1t1v3_4t_4ll}`


