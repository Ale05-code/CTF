# TheMessage - Stego (caratteri invisibili / zero-width)

**Flag:** `CTFlearn{If_y0u_r3/\d_thi5_you_pa553d}`

## File
`TheMessage.txt`, `hidde.txt`, `hidden.txt` - contengono solo due tipi di carattere invisibile:
- lo **spazio** normale (`0x20`)
- il **RIGHT-TO-LEFT MARK** `U+200F` (byte `E2 80 8F`, che `cat -v` mostra come `M-bM-^@M-^O`)

I due caratteri codificano i bit: RLM = `1`, spazio = `0`. Ogni 8 bit --> 1 carattere ASCII.

## Soluzione - passo per passo
1. Entra nella cartella:
   ```
   cd zero_width
   ```
2. Decodifica con questo script (RLM --> bit 1, spazio --> bit 0, gruppi da 8 bit):
   ```
   python3 -c '
   data = open("TheMessage.txt", encoding="utf-8").read()
   RLM = "‏"
   seq = [c for c in data if c in (" ", RLM)]
   bits = "".join("1" if c == RLM else "0" for c in seq)
   out = "".join(chr(int(bits[i:i+8], 2)) for i in range(0, len(bits)-7, 8))
   print(out)
   '
   ```
3. L'output contiene un breve testo e, in fondo, la flag:
   ```
   ...
   CTFlearn{If\_y0u\_r3/\d\_thi5\_you\_pa553d}
   ```


