# Snowboard - Stego / Forensics (commenti EXIF)

**Flag:** `CTFlearn{CTFIsEasy!!!}`  (+ bonus base64: `CTFlearn{SkiBanff}`)

## Analisi
La flag e' nei **commenti EXIF/JPEG**.

## Soluzione - passo per passo
1. Entra nella cartella:
   ```
   cd snowboard
   ```
2. Leggi il commento:
   ```
   exiftool -Comment Snowboard.jpg
   ```
   Output --> `Comment : CTFlearn{CTFIsEasy!!!}.`
3. (Bonus) nel file c'e' anche una stringa base64. Decodificala:
   ```
   echo Q1RGbGVhcm57U2tpQmFuZmZ9Cg== | base64 -d
   ```
   Output --> `CTFlearn{SkiBanff}`

Per trovare la base64 nel file:
```
strings Snowboard.jpg | grep Q1RG
```

