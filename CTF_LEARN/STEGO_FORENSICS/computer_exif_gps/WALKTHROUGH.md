# Computer-Password (EXIF) - Forensics

**Flag:** `flag{3l1t3_3x1f_4uth0r1ty_dud3br0}`

## Analisi
La flag e' nei metadati **EXIF**, nel campo **Owner Name** (non nel GPS: le coordinate GPS sono un depistaggio).

## Soluzione - passo per passo
1. Entra nella cartella:
   ```
   cd computer_exif_gps
   ```
2. Leggi tutti i metadati e cerca la flag:
   ```
   exiftool "Computer-Password-Security-Hacker - Copy.jpg" | grep -i 'owner\|flag'
   ```
   Output --> `Owner Name : flag{3l1t3_3x1f_4uth0r1ty_dud3br0}`

### Metodo rapido alternativo
```
strings "Computer-Password-Security-Hacker - Copy.jpg" | grep -i flag
```
--> `flag{3l1t3_3x1f_4uth0r1ty_dud3br0}`


