# math.jpg - Stego + Math

**Flag:** `CTFlearn{I_Like_Math_2_5}`

## Analisi
Il commento EXIF del JPEG annuncia il formato della flag e due equazioni da risolvere:
```
The flag for this challenge is of the form:
CTFlearn{I_Like_Math_x_y}
where x and y are the solution to these equations:
3x + 5y = 31
7x + 9y = 59
```

## Soluzione - passo per passo
1. Entra nella cartella e leggi il commento:
   ```
   cd math_jpg
   exiftool -Comment math.jpg
   ```
2. Risolvi il sistema (con Python):
   ```
   python3 -c "
   import numpy as np
   x, y = np.linalg.solve([[3,5],[7,9]], [31,59])
   print(f'CTFlearn{{I_Like_Math_{int(round(x))}_{int(round(y))}}}')
   "
   ```
   Output --> `CTFlearn{I_Like_Math_2_5}`

Verifica a mano: `x=2, y=5` --> `3*2+5*5 = 31` e `7*2+9*5 = 59`.

> Risolto: la flag e' `CTFlearn{I_Like_Math_2_5}`.
