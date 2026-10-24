# raw.txt - Crypto (Base64 + UTF-16)

**Flag:** `CTFlearn{this_is_fun}`

## Analisi
`raw.txt` contiene `AEMAVABGAGwAZQBhAHIAbgB7AHQAaABpAHMAXwBpAHMAXwBmAHUAbgB9`.
E' base64 di testo in **UTF-16 big-endian** (si notano i byte `00` alternati --> nel base64 compaiono le `A` ripetute).

## Soluzione - passo per passo
1. Entra nella cartella:
   ```
   cd raw_utf16
   ```
2. Decodifica base64 e poi converti da UTF-16BE a UTF-8:
   ```
   cat raw.txt | base64 -d | iconv -f UTF-16BE -t UTF-8
   ```
   Output --> `CTFlearn{this_is_fun}`

