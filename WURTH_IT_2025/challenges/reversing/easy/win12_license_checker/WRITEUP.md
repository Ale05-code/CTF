# Win12 License Checker — Writeup

**CTF:** WPCTF 2025
**Categoria:** Reversing (easy)
**Flag:** `WPCTF{2026_1s_Th3_ye4R_0f_7he_l1nuX_d3skt0p}`

## La challenge

> After the deprecation of Windows 10, the IT department has decided to upgrade all
> systems to Macrohard Linux 12. [...] Can you help them understand why their key is not working?

Abbiamo un programma Rust che chiede una chiave di licenza e la rifiuta sempre.
L'obiettivo è capire come viene verificata la chiave e costruirne una valida, che è la flag.

## 1. Il flusso del programma (`main`)

1. Stampa il banner e legge una riga di input.
2. Se il sistema operativo non è Linux, stampa un messaggio di trolling e termina.
3. Chiama `check_input(input.as_bytes())`:
   - se restituisce `true`, stampa **"Correct!"**
   - altrimenti stampa un finto `sudo rm -rf --no-preserve-root /` (è solo una stampa, non esegue niente).

Tutto quindi dipende da `check_input`.

## 2. Il controllo (`check_input`)

```rust
fn check_input(bytes: &[u8]) -> bool {
    if bytes.len() != KEY.len() {
        return false;
    }
    for (i, &b) in bytes.iter().enumerate() {
        let v = transform_byte(i, b);
        if v != KEY[i] {
            return false;
        }
    }
    true
}
```

Cosa abbiamo notato:

- **Lunghezza:** l'input deve avere tanti byte quanti sono gli elementi di `KEY`, cioè **44** (`[u32; 44]`). (u32 restituisce un numero intero da 32 bit senza segno)
- **`enumerate()`** restituisce coppie `(posizione, elemento)`:
  - `i` è la **posizione** del carattere nella chiave (0, 1, 2, …, 43). Che sia di tipo `usize` qui non conta: conta che sia l'indice.
  - `&b` è un **destructuring**: `iter()` restituisce riferimenti `&u8`, e il pattern `&b` li "spacchetta", quindi `b` è direttamente il valore del byte. Non si sta usando un puntatore.
- Per ogni posizione deve valere **`transform_byte(i, b) == KEY[i]`**.

## 3. La trasformazione (`transform_byte`)

```rust
fn transform_byte(i: usize, b: u8) -> u32 {
    let mut v = (b as u32).wrapping_mul(MUL);                   // MUL = 0x7f3a21c9
    let rot = (i % 13) as u32;
    v = v.rotate_left(rot);
    v = v.wrapping_add(ADD_BASE.wrapping_mul((i as u32).wrapping_add(1)));  // ADD_BASE = 0x1337
    v
}
```

Le operazioni, nell'ordine:

| # | Operazione | Note |
|---|---|---|
| 1 | `v = b * MUL` | prima `b` viene convertito in `u32`; `wrapping_mul` --> il risultato è **mod 2³²** (l'overflow non è ignorato, il valore si "avvolge") |
| 2 | `v = rotate_left(v, i % 13)` | la rotazione dipende dalla posizione |
| 3 | `v = v + ADD_BASE * (i + 1)` | anche questa con `wrapping`, quindi mod 2³² |

### Il valore di `i % 13`

Una prima ipotesi era "si ruota sempre di 13". È sbagliata: `%` è il **resto della divisione**.

| `i` | `i % 13` |
|---|---|
| 0 | 0 |
| 1 | 1 |
| 12 | 12 |
| 13 | 0 |
| 14 | 1 |

La rotazione va da 0 a 12 e poi **ricomincia**: è ciclica, non lineare. Per `i = 0` e `i = 13` non si ruota affatto.

## 4. Impostare il problema

Pensando alla chiave come a una tabella:

| posizione `i` | carattere `b` | valore finale |
|---|---|---|
| 0 | ? | `KEY[0]` |
| 1 | ? | `KEY[1]` |
| … | ? | … |

- **`i` lo conosciamo**: è solo la posizione. Ci serve perché le operazioni dipendono da lei (quanto si aggiunge, di quanto si ruota).
- **`KEY[i]` lo conosciamo**: è scritto nel binario.
- **`b` è l'incognita**: messi insieme, i `b` formano la flag.

Le strade possibili erano due:
- **A) Invertire** le operazioni partendo da `KEY[i]`.
- **B) Forza bruta**: per ogni `i` provare tutti i 256 valori di `b`.

Abbiamo scelto la **A**.

## 5. Invertire le operazioni

Le operazioni si annullano **in ordine inverso** (come vestirsi e svestirsi: l'ultima cosa messa è la prima da togliere). Quindi 3 --> 2 --> 1.

### Passo 3 --> sottrazione

È stato aggiunto `ADD_BASE * (i + 1)`, quindi lo sottraiamo:

```python
v = (KEY[i] - 0x1337 * (i + 1)) & 0xFFFFFFFF
```

Esempio: per `i = 0` si sottrae `0x1337 * 1 = 4919`; per `i = 2` si sottrae `0x1337 * 3`.

Il `& 0xFFFFFFFF` serve perché la sottrazione potrebbe andare sotto zero: così il risultato si "riavvolge" e resta un valore valido a 32 bit, come faceva `wrapping_add` all'andata.

### Passo 2 --> rotazione a destra

Una rotazione a sinistra di `r` si annulla con una rotazione a destra di `r`, con lo stesso `i % 13`.
Python non ha una rotazione a 32 bit già pronta, quindi l'abbiamo costruita:

```python
def rotr(val, shift):
    return ((val >> shift) | (val << (32 - shift))) & 0xFFFFFFFF
```

- `val >> shift` --> i bit si spostano a destra
- `val << (32 - shift)` --> i bit "caduti fuori" rientrano da sinistra
- `|` --> unisce le due parti (servono **entrambe**, non una o l'altra)
- `& 0xFFFFFFFF` --> tiene solo 32 bit

Nota: con `shift = 0`, `val << 32` genera bit oltre il 32°, ma la maschera li elimina. In Python va bene; in C o Rust shiftare di 32 un intero a 32 bit sarebbe un problema.

### Passo 1 --> inverso moltiplicativo modulare

Dopo i primi due passi `v = b * MUL (mod 2³²)`. **Non si può dividere** per `MUL`, perché la moltiplicazione ha buttato via i bit alti.

Serve un numero `MUL_INV` tale che:

```
(MUL * MUL_INV) mod 2³² = 1
```

Così `v * MUL_INV = b * MUL * MUL_INV = b (mod 2³²)`.

- **Esiste?** Modulo 2³² l'inverso esiste solo per i numeri **dispari**. `0x7f3a21c9` finisce con `9`, quindi è dispari. 
- **Come si calcola?** Con `pow(base, esponente, modulo)`. Come l'inverso di 5 è 5⁻¹ = 1/5, l'esponente è **-1**; il modulo è **2³²** perché lavoriamo a 32 bit:

```python
MUL_INV = pow(0x7f3a21c9, -1, 2**32)
```

Attenzione: in Python `2^32` **non** è una potenza, `^` è lo XOR. Si scrive `2**32`.

Quindi:

```python
b = (v * MUL_INV) & 0xFFFFFFFF
```

## 6. Lo script

La soluzione completa e commentata è in [`solve.py`](solve.py). Il cuore è:

```python
for i in range(len(KEY)):
    v = (KEY[i] - ADD_BASE * (i + 1)) & 0xFFFFFFFF   # annulla la somma
    v = rotr(v, i % 13)                               # annulla la rotazione
    b = (v * MUL_INV) & 0xFFFFFFFF                    # annulla la moltiplicazione
    flag += chr(b)
```

Alla prima versione stampavamo `b` così com'era, ottenendo 44 numeri (codici ASCII). Con `chr(b)` e unendo i caratteri in una stringa esce la flag:

```
$ python3 solve.py
WPCTF{2026_1s_Th3_ye4R_0f_7he_l1nuX_d3skt0p}
```

## Cosa ho imparato

- Leggere un checker partendo dal messaggio di successo e risalendo al controllo.
- `enumerate()` e il destructuring `&b` in Rust.
- Le operazioni `wrapping_*` lavorano **mod 2³²**, e bisogna tenerne conto quando si invertono (`& 0xFFFFFFFF`).
- `%` dà un andamento **ciclico**.
- Le operazioni si invertono **in ordine inverso**.
- Rotazione a destra = shift a destra `|` shift a sinistra del complemento a 32.
- La moltiplicazione modulare si inverte con l'**inverso moltiplicativo modulare**, che esiste solo se il numero è coprimo con il modulo (qui: dispari) --> `pow(x, -1, 2**32)`.
