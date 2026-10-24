# gitIsGood - Misc (Git forensics)

**Flag:** `flag{protect_your_git}`

## Analisi
Nel repo `gitIsGood/` il file `flag.txt` attuale contiene `flag{REDACTED}`: la flag vera e' stata **sovrascritta in un commit successivo** ma resta nella storia git.

## Soluzione - passo per passo
1. Entra nel repository:
   ```
   cd git_is_good/gitIsGood
   ```
2. Guarda tutti i commit:
   ```
   git log --all --oneline
   ```
   Escono 3 commit: `d10f77c`, `195dd65`, `6e824db`.
3. Mostra il contenuto di `flag.txt` nel commit intermedio:
   ```
   git show 195dd65:flag.txt
   ```
   Output --> `flag{protect_your_git}`

### In alternativa - controlla la flag in TUTTI i commit
```
for c in $(git log --all --format=%H); do git show $c:flag.txt; done
```
Solo il commit `195dd65` contiene la flag vera; gli altri due hanno `flag{REDACTED}`.

> Testato: la flag vera e' nel commit `195dd65`.
