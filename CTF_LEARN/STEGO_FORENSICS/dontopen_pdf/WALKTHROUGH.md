# dontopen.pdf - Forensics (file allegato nel PDF)

**Flag:** `CTFlearn{)_1l0w3y0Um00my123}`

## Analisi
Il PDF contiene un **file allegato** nascosto (`.backup`) con dentro alcune stringhe base64; una e' la flag vera, le altre sono depistaggi.

## Soluzione - passo per passo
1. Entra nella cartella:
   ```
   cd dontopen_pdf
   ```
2. Elenca gli allegati:
   ```
   pdfdetach -list dontopen.pdf
   ```
   --> `1 embedded files ... .backup`
3. Estrai l'allegato:
   ```
   pdfdetach -save 1 -o backup.txt dontopen.pdf
   cat backup.txt
   ```
   Contenuto:
   ```
   == SECRET DATA DONT LOOK AT THIS ==
   external:Q1RGbGVhcm57KV8xbDB3M3kwVW0wMG15MTIzfQ==
   pin:1234
   password:MTIzMVdST05HOWlzamRuUEFTU1dPUkQ=
   ```
4. Decodifica la riga `external` (le altre sono esche):
   ```
   echo 'Q1RGbGVhcm57KV8xbDB3M3kwVW0wMG15MTIzfQ==' | base64 -d
   ```
   Output --> `CTFlearn{)_1l0w3y0Um00my123}`


