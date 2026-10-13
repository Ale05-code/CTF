#!/usr/bin/env python3
# Win12 License Checker - solve
#
# Il checker (src/main.rs) trasforma ogni carattere b della chiave, in posizione i, così:
#   1. v = b * MUL                  (mod 2^32, wrapping_mul)
#   2. v = rotate_left(v, i % 13)
#   3. v = v + ADD_BASE * (i + 1)   (mod 2^32, wrapping_add)
# e confronta il risultato con KEY[i].
#
# Conosciamo i (la posizione) e KEY[i] (il valore finale): ci manca solo b.
# Per trovarlo applichiamo le operazioni inverse in ordine inverso (3 -> 2 -> 1).

# Valori attesi copiati da src/main.rs (in Rust: const KEY: [u32; 44])
# 44 elementi = la chiave deve essere lunga esattamente 44 caratteri
KEY = [
    1019317894, 2220180495, 819697682, 4170775681, 2656317311, 499639726, 1453774647, 1932227109,
    1520037832, 2252443090, 1244082231, 62697829, 3537218620, 915642009, 2116504610, 3195542034,
    3299286785, 1764356945, 1329622329, 2077660056, 3882876398, 2664696186, 622127198, 2572718227,
    1269994984, 681273087, 1434405116, 1597869397, 3351215727, 3029765419, 3362152563, 1141986827,
    3198390721, 3367697376, 4221548864, 622191145, 3570194877, 2782606574, 3537346514, 760160155,
    1286713848, 1805417929, 1266252226, 4130029509,
]

MUL = 0x7F3A21C9
ADD_BASE = 0x1337

# Inverso moltiplicativo modulare di MUL modulo 2^32:
# (MUL * MUL_INV) mod 2^32 == 1
# Esiste solo perché MUL è dispari (ultima cifra hex = 9).
# Non si può "dividere" per MUL perché la moltiplicazione originale ha perso i bit alti.
MUL_INV = pow(MUL, -1, 2**32)


def rotr(val, shift):
    # Rotazione a destra su 32 bit (Python non ce l'ha già pronta):
    # - val >> shift          -> i bit si spostano a destra
    # - val << (32 - shift)   -> i bit "caduti fuori" rientrano da sinistra
    # - |                     -> unisce le due parti
    # - & 0xFFFFFFFF          -> tiene solo 32 bit (gestisce anche shift = 0)
    return ((val >> shift) | (val << (32 - shift))) & 0xFFFFFFFF


flag = ""
for i in range(len(KEY)):
    # Passo 3 annullato: sottraiamo quello che era stato aggiunto in posizione i.
    # & 0xFFFFFFFF fa "riavvolgere" il risultato se la sottrazione va sotto zero.
    v = (KEY[i] - ADD_BASE * (i + 1)) & 0xFFFFFFFF

    # Passo 2 annullato: rotazione a sinistra -> rotazione a destra della stessa quantità.
    # i % 13 va da 0 a 12 e poi ricomincia (ciclico, non lineare).
    v = rotr(v, i % 13)

    # Passo 1 annullato: moltiplicare per l'inverso modulare riporta a b.
    b = (v * MUL_INV) & 0xFFFFFFFF

    # b è un codice ASCII: chr() lo trasforma nel carattere
    flag += chr(b)

print(flag)
