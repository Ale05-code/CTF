# CTFlearn - Indice delle challenge

Challenge di **ctflearn.com**, riordinate per categoria. In ogni cartella
ci sono i file originali e un `WALKTHROUGH.md` con analisi, soluzione e flag.

Struttura:
```
PWN/              binary exploitation (14)
REVERSING/        reverse engineering (3)
STEGO_FORENSICS/  steganografia e forensics (16)
CRYPTO_MISC/      crypto, programming, misc (6)
_tools/           stegsolve.jar (strumento)
_misc_downloads/  download residui / duplicati
```

## PWN
| Cartella | Tecnica | Flag |
|---|---|---|
| accumulator | integer overflow (int) | `CTFlearn{n3x7_7yp3_0f_0v3rf0w}` |
| positive\_challenge | short overflow / abs(INT16\_MIN) | `CTFlearn{n0t_s0_p0s1t1v3_4t_4ll}` |
| math | equazione modulare 2^64 (X=`9585860797856392871`) | `CTFlearn{ju5t_4_m0dul0_3qu4t10n}` |
| leak\_me | format string (leak) | `CTFlearn{1_l1k3_f0rm4t_t4g5_t00}` |
| readme2 | format string (arbitrary read) | `CTFlearn{ju57_4n_4rb17r4ry_r34d}` |
| cookies | format string + stack canary | `CTFlearn{d0_y0u_kn0w_why_s74ck_c00ki3_h4s_4_nu11_by73_1n_17?}` |
| twoTimes16 | stack overflow + arg control | `CTFlearn{h3yyy_n0w_y0u_h4v3_7h3_c0n7r0l}` |
| glob | partial pointer overwrite | `CTFlearn{p4rt14l_ptr_0v3rwr1t3}` |
| secret | strncmp / null byte + bruteforce | `CTFlearn{7r1cky_nu11_by73s}` |
| domain | command injection | `CTFlearn{1s_c0mm4nd_1nj3ct10n_4_th1ng?}` |
| runner | shellcode execution | `CTFlearn{n0t_s0_st4nd4rd_sh3llc0d3}` |
| slope | buffer leak + NOP sled jump | `CTFlearn{y0u_n3v3r_kn0w_wh3r3_th3_buff3r_15}` |
| random\_malloc | heap memory reuse | `CTFlearn{h34p_m3m0ry_r3us1ng}` |
| school | no type checking | `CTFlearn{n0_7yp3_ch3ck1ng}` |

## REVERSING
| Cartella | Tecnica | Flag |
|---|---|---|
| antigua_rust | LCG + XOR (Rust) | `CTFlearn{FreeT0wn.P1cadilly}` |
| reykjavik | reversing binario (ltrace su strcmp) | `CTFlearn{Eye_L0ve_Iceland_}` (false flag: `CTFlearn{Is_This_A_False_Flag?}`) |
| android\_apk | APK, MD5 crack | `CTFlearn{<pwd>_is_not_secure!}` (MD5 `b74dec4f39d35b6a2e6c48e637c8aedb`) |

## STEGO / FORENSICS
| Cartella | Tecnica | Flag |
|---|---|---|
| snowboard | commento EXIF / base64 | `CTFlearn{CTFIsEasy!!!}` · `CTFlearn{SkiBanff}` |
| pikespeak | commenti EXIF (tra depistaggi) | `CTFLEARN{PikesPeak}` |
| gandalf | base64 + XOR | `CTFlearn{xor_is_your_friend}` |
| tux | EXIF base64 + ZIP (pwd Linux12345) | `CTFlearn{Linux_Is_Awesome}` |
| computer\_exif\_gps | EXIF/GPS | `flag{3l1t3_3x1f_4uth0r1ty_dud3br0}` |
| math\_jpg | commento EXIF + sistema di equazioni | `CTFlearn{I_Like_Math_2_5}` |
| purplething | PNG dentro PNG (dd offset 153493) | `ABCTF{b1nw4lk_is_us3ful}` |
| output\_png | testo visibile nell'immagine | `ABCTF{b1nw4lk_is_us3ful}` |
| audio\_wav | spettrogramma audio | nello spettrogramma |
| dontopen\_pdf | file allegato nel PDF + base64 | `CTFlearn{)_1l0w3y0Um00my123}` |
| abandoned\_street | altezza JPEG falsificata | `CTFlearn{urban_exploration}` (testo: `urban_exploration`) |

## CRYPTO / MISC
| Cartella | Tecnica | Flag |
|---|---|---|
| raw\_utf16 | base64 + UTF-16 | `CTFlearn{this_is_fun}` |
| git\_is\_good | git history | `flag{protect_your_git}` |
| zero\_width | stego caratteri invisibili (RLM/spazio) | `CTFlearn{If_y0u_r3/\d_thi5_you_pa553d}` |
| programming\_dat | scripting (conteggio) | `6662` |
| remote\_bof | BOF remoto (thekidofarcrania.com:35235) | dal server |


> Nota: alcune flag di stego/forensics richiedono di eseguire l'ultimo step
> (aprire un'immagine, spettrogramma, crack hash/password): nei rispettivi
> WALKTHROUGH.md ci sono i comandi e procedura.
