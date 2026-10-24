# secret - PWN (Null byte / strncmp trick + bruteforce)

**Flag:** `CTFlearn{7r1cky_nu11_by73s}`

## Analisi
Genera una password casuale di 32 caratteri, solo lettere **a-f** (`(rand()%6)+97`), con seed imprevedibile. Legge fino a 32 byte in `user_input` (che e' pre-riempito di `'-'`), calcola `input_len = strlen(user_input)` e fa `strncmp(secret, user_input, input_len)`. Se i primi `input_len` byte combaciano --> flag. Serve `input_len > 1`.

## Il trucco ("tricky null bytes")
`user_input` e' pre-riempito di `'-'` e la `read` **non** lo termina con `\0`. Quindi se mandi solo `aa` (2 byte), `strlen` NON vale 2: continua a leggere i `'-'` successivi --> confronto lunghissimo che non passa mai. (Era questo il bug del comando vecchio.)

**Fix:** manda `aa\x00` --> il null byte forza `strlen == 2`. Cosi' `strncmp` confronta solo i primi 2 caratteri. La password usa solo `a-f`, quindi `aa` combacia con probabilita' `1/6 * 1/6 = 1/36`. Si ripete finche' esce (in media ~36 tentativi).

## Soluzione - passo per passo
1. Entra nella cartella:
   ```
   cd secret
   ```
2. Bruteforce con `aa\x00` finche' esce la flag:
   ```
   for i in $(seq 1 400); do
     out=$(python3 -c "import sys;sys.stdout.buffer.write(b'aa\x00')" | ./task 2>/dev/null)
     echo "$out" | grep -q CTFlearn && { echo "$out" | grep CTFlearn; break; }
   done
   ```
   Output --> `Here is your prize: CTFlearn{7r1cky_nu11_by73s}`


