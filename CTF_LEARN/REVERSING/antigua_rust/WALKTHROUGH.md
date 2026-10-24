# Antigua - Reversing (Rust: LCG + XOR)

**Flag:** `CTFlearn{FreeT0wn.P1cadilly}`

## File
- `main.rs` - sorgente Rust
- `main` - binario ELF gia' compilato

## Analisi
Il programma:
1. genera 18 valori `u32` con un **LCG**: `x = (1664525*x + 1013904223) mod 2^32`, seed iniziale `0xbaadf00d`;
2. ha un vettore di 18 byte costanti;
3. fa lo **XOR** del byte basso di ogni valore LCG con il byte corrispondente --> ricostruisce la flag.

## Soluzione - passo per passo
Non serve compilare Rust: si riproduce l'algoritmo in Python.

1. Esegui:
   ```
   python3 -c '
   def lcg(x): return (1664525*x + 1013904223) % (2**32)
   s = 0xbaadf00d; v = []
   for _ in range(18): s = lcg(s); v.append(s)
   u8 = [0x4e,0xb5,0x1f,0xf4,0xe8,0xdb,0x39,0x3b,0x9e,0x1f,0x53,0x3a,0x85,0x97,0xdf,0xf1,0x34,0xae]
   print("CTFlearn{" + "".join(chr((a & 0xff) ^ b) for a, b in zip(v, u8)) + "}")
   '
   ```
   Output --> `CTFlearn{FreeT0wn.P1cadilly}`

### In alternativa (se hai rustc)
```
rustc main.rs && ./main
```


