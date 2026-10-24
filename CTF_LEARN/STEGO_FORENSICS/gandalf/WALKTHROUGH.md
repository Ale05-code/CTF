# Gandalf - Stego + Crypto

**Flag:** `CTFlearn{xor_is_your_friend}`

## Analisi
Il JPEG ha dei commenti EXIF. Il primo e' base64 e contiene gia' la flag; gli altri due sono dati XOR (depistaggi/extra).

## Soluzione - passo per passo
1. Entra nella cartella:
   ```
   cd gandalf
   ```
2. Leggi il commento:
   ```
   exiftool -Comment Gandalf.jpg
   ```
   Output --> `Comment : Q1RGbGVhcm57eG9yX2lzX3lvdXJfZnJpZW5kfQo=.`
3. Decodifica la base64:
   ```
   echo 'Q1RGbGVhcm57eG9yX2lzX3lvdXJfZnJpZW5kfQo=' | base64 -d
   ```
   Output --> `CTFlearn{xor_is_your_friend}`


