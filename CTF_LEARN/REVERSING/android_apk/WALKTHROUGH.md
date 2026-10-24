# BasicAndroidRE1 - Reversing (Android APK, MD5 crack)

**Flag:** `CTFlearn{<password>_is_not_secure!}`
dove `<password>` e' la stringa il cui **MD5** e' `b74dec4f39d35b6a2e6c48e637c8aedb`.
**Stato:** l'hash va craccato con un wordlist/servizio online; qui non c'e' `rockyou.txt`, quindi fornisco la procedura (la flag si completa inserendo la password craccata).

## File
- `BasicAndroidRE1.apk` - l'app Android
- `out_apk/` - APK gia' decodificato con apktool

## Analisi
L'app chiede una password, ne calcola l'MD5 e lo confronta (ignore-case) con un hash fisso. In `out_apk/smali/com/example/secondapp/MainActivity.smali`:
```
const-string v1, "b74dec4f39d35b6a2e6c48e637c8aedb"   # MD5 atteso
... equalsIgnoreCase ...
const-string v2, "Success! CTFlearn{"
append(input)
const-string p1, "_is_not_secure!}"
```
Se l'MD5 dell'input combacia --> mostra `CTFlearn{<input>_is_not_secure!}`.

## Soluzione - passo per passo
1. Trova l'hash atteso nel codice:
   ```
   grep -rao 'b74dec4f39d35b6a2e6c48e637c8aedb' android_apk/out_apk/smali/
   ```
2. **Cracca l'MD5** `b74dec4f39d35b6a2e6c48e637c8aedb`:
   - online: incollalo su CrackStation (https://crackstation.net) - metodo piu' rapido per questa challenge;
   - oppure con hashcat/john e rockyou:
     ```
     echo 'b74dec4f39d35b6a2e6c48e637c8aedb' > hash.txt
     hashcat -m 0 -a 0 hash.txt /usr/share/wordlists/rockyou.txt
     # oppure
     john --format=raw-md5 --wordlist=/usr/share/wordlists/rockyou.txt hash.txt
     ```
3. La parola trovata e' la `<password>`. La flag finale e':
   ```
   CTFlearn{<password>\_is\_not\_secure!}
   ```

### Per leggere il codice in Java
Apri `BasicAndroidRE1.apk` con **jadx** / jadx-gui.
