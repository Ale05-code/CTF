# Tux - Stego (password EXIF + ZIP embeddato)

**Flag:** `CTFlearn{Linux_Is_Awesome}`  (password: `Linux12345`)

## Analisi
1. Un commento EXIF (base64) contiene la password.
2. Dentro il JPEG c'e' un archivio ZIP nascosto (gia' estratto da binwalk in `_Tux.jpg.extracted/1570.zip`), con dentro un file `flag`.
3. La password serve per aprire lo ZIP.

## Soluzione - passo per passo
1. Entra nella cartella:
   ```
   cd tux
   ```
2. Leggi il commento e decodifica la password:
   ```
   exiftool -Comment Tux.jpg
   echo ICAgICAgUGFzc3dvcmQ6IExpbnV4MTIzNDUK | base64 -d
   ```
   Output --> `      Password: Linux12345`
3. (Se non e' gia' estratto) ricava lo ZIP:
   ```
   binwalk -e Tux.jpg
   ```
4. Estrai lo ZIP con la password e leggi la flag:
   ```
   unzip -P Linux12345 _Tux.jpg.extracted/1570.zip -d out
   cat out/flag
   ```
   Output --> `CTFlearn{Linux_Is_Awesome}`

