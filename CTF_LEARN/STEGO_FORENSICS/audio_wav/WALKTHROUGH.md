# you_know_what_to_do.wav - Audio Stego (spettrogramma)

**Flag:** si legge nello **spettrogramma** dell'audio
**Stato:** generato lo spettrogramma, ma la flag non si legge a colpo d'occhio con i parametri base (l'audio e' PCM 8-bit 8000 Hz mono). Serve aprirlo in un tool audio e regolare i parametri. Ecco la procedura testata per generarlo.

## Soluzione - passo per passo
1. Entra nella cartella:
   ```
   cd audio_wav
   ```
2. Usa tool online
- **Audacity**: importa il wav --> cambia la traccia in vista **Spettrogramma**.
- **Sonic Visualiser**: `Layer --> Add Spectrogram`.
Regola la finestra FFT finche' il testo e' leggibile.


