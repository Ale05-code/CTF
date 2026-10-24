# Abandoned Street - Forensics (altezza JPEG falsificata)

**Testo nascosto (flag):** `urban_exploration`  (formato CTFlearn: `CTFlearn{urban_exploration}`)

## Analisi
La challenge ha modificato i byte dell'**altezza** nel marker SOF del JPEG per **tagliare** la parte bassa dell'immagine, dove e' scritto il testo nascosto.
- `abondoned_street_challenge2.jpg` --> altezza falsa `0x0384` = 900 px (immagine tagliata)
- `abondoned_street_challenge2_1.jpg` --> altezza corretta `0x0500` = 1280 px (immagine **gia' sistemata**)

La differenza e' ai byte 164-165 (`cmp -l` lo conferma).

## Soluzione - passo per passo
1. Entra nella cartella:
   ```
   cd abandoned_street
   ```
2. Conferma la differenza di altezza tra le due copie:
   ```
   cmp -l abondoned_street_challenge2.jpg abondoned_street_challenge2_1.jpg
   identify abondoned_street_challenge2.jpg abondoned_street_challenge2_1.jpg
   ```
3. Apri la versione con altezza corretta e guarda in **fondo** all'immagine:
   ```
   xdg-open abondoned_street_challenge2_1.jpg
   ```
   In basso c'e' scritto --> `urban_exploration`

### Se avessi solo la versione tagliata
Correggi l'altezza da `0x0384` (900) a `0x0500` (1280) con un editor esadecimale ai byte 164-165 (quelli dell'altezza nel SOF0 `FF C0`), poi riapri l'immagine.


