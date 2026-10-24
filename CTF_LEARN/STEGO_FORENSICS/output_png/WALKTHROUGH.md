# output.png - Stego

**Flag:** `ABCTF{b1nw4lk_is_us3ful}`

## Analisi
PNG 802x118: la forma allungata e' tipica di **testo renderizzato**. La flag NON e' nei bit LSB (`zsteg` non trova nulla): e' semplicemente **scritta visibilmente** nell'immagine.

## Soluzione - passo per passo
1. Entra nella cartella:
   ```
   cd output_png
   ```
2. Apri l'immagine:
   ```
   xdg-open output.png
   ```
   Nell'immagine c'e' scritto --> `ABCTF{b1nw4lk_is_us3ful}`

### Controlli extra (per confermare che non e' LSB)
```
zsteg -a output.png      # non trova flag -> e' testo visibile
exiftool output.png
```

