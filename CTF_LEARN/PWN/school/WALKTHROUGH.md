# school - PWN / RE (No type checking - method pointer confusion)

**Flag:** `CTFlearn{n0_7yp3_ch3ck1ng}`

## Analisi (dal disassemblato, sorgente non incluso)
Ogni "persona" e' uno struct sull'heap con, all'offset `0x20`, un **puntatore a funzione** (il "metodo"). Il flusso:
1. crea uno Studente e un Professore (entrambi finiscono nello stesso array `person[]`);
2. chiede il nome di chi **da'** il voto --> `find_student(nome)` restituisce la persona;
3. chiede il nome di chi **riceve** --> `find_professor(nome)`;
4. legge il voto;
5. chiama `giver->metodo(receiver, voto)` tramite `call rdx`, dove `rdx = giver->[0x20]`.

La vulnerabilita' ("no type checking"): `find_student` e `find_professor` cercano nello **stesso** array, senza distinguere il tipo, e il puntatore a metodo chiamato (`call rdx`) viene preso da `giver->[0x20]`. Normalmente e' `give_score`; l'obiettivo e' farlo diventare **`print_flag`** (`@ 0x401296`).

## Soluzione - passo per passo (via GDB, verificata sul binario locale)
Il binario locale apre `./flag.txt`, quindi si puo' vedere la flag. Il modo piu' pulito per dimostrare/leggere la flag e' deviare `call rdx` su `print_flag`:

1. Entra nella cartella:
   ```
   cd school
   ```
2. Crea lo script GDB:
   ```
   cat > solve.gdb <<'EOF'
   set debuginfod enabled off
   break *0x40166b
   run
   set $rdx = 0x401296
   continue
   EOF
   ```
3. Esegui dando input qualsiasi (servono un nome studente e uno professore validi):
   ```
   printf 'Stud\nProf\nStud\nProf\n5\n' | gdb -q -batch -x solve.gdb ./task
   ```
   Output --> `CTFlearn{n0_7yp3_ch3ck1ng}`

- `0x40166b` e' l'istruzione `call rdx`.
- `print_flag @ 0x401296`.

