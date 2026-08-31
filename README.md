# VSCode.Setup

Forslag til VS Code-oppsett for **Thomas (B82MAS)** — VS Code som hovedprogram for kode, dokumentasjon, wiki og prosjektarbeid.

> **Viktig forbehold:** Jeg har ikke tilgang til historikken din fra andre chat-sesjoner eller til andre repos/prosjekter enn dette (tomme) repoet. Forslaget under er derfor bygget på det jeg *kan* observere i denne sesjonen — settet av spesialiserte skills/agenter som er koblet til kontoen din (cybersikkerhet/OT-ICS, cloud- og DevOps-arkitektur, Terraform/Kubernetes, ESP32/IoT, fullstack webutvikling, PowerShell/Windows- og Ubuntu-drift, Notion, dokumentproduksjon i Office-formater, prosjektledelse/R&D) — samt B82MAS-konteksten (CTO/Founder, cybersikkerhet, cloud-arkitektur, IT-infrastruktur). Bruk dette som et **utgangspunkt**, juster gjerne mappenavn og profiler etter hva som faktisk stemmer.

## Innhold

| Fil | Beskrivelse |
|---|---|
| `.vscode/settings.json` | Workspace-innstillinger (editor, filhåndtering, Markdown/wiki, git) |
| `.vscode/extensions.json` | Anbefalte extensions, gruppert per fagområde |
| `docs/mappestruktur.md` | Forslag til mappestruktur for hovedarbeidsområdet |
| `docs/profiler.md` | VS Code-profiler (ett sett extensions/innstillinger per rolle) |
| `docs/themes-og-ikoner.md` | Tema-, ikon- og fontanbefalinger |
| `docs/keybindings.md` | Noen nyttige tastatursnarveier å legge til |

## Kjapp start

1. Åpne hovedmappen din (se `docs/mappestruktur.md`) som **multi-root workspace** i VS Code.
2. Kjør oppsettskriptet for din plattform (se under) — installerer extensions og kopierer settings automatisk.
3. Sett opp profilene i `docs/profiler.md` (`Ctrl+Shift+P` → *Profiles: Create Profile*).
4. Velg tema fra `docs/themes-og-ikoner.md`.

## Oppsettskript

`scripts/setup.sh` (Linux/macOS) og `scripts/setup.ps1` (Windows) installerer alle anbefalte extensions fra `.vscode/extensions.json` via VS Code CLI, og kopierer `.vscode/settings.json` inn i din globale VS Code User-profil (med automatisk backup av evt. eksisterende fil).

**Forutsetning:** `code`-kommandoen må være tilgjengelig i PATH (i VS Code: `Ctrl+Shift+P` → *Shell Command: Install 'code' command in PATH*).

### Linux / macOS
```bash
git clone https://github.com/B82mas/VScode.Setup.git
cd VScode.Setup
./scripts/setup.sh            # kjør oppsettet
./scripts/setup.sh --dry-run  # se hva som ville blitt gjort, uten å endre noe
```

### Windows (PowerShell)
```powershell
git clone https://github.com/B82mas/VScode.Setup.git
cd VScode.Setup
.\scripts\setup.ps1            # kjør oppsettet
.\scripts\setup.ps1 -DryRun    # se hva som ville blitt gjort, uten å endre noe
```

Begge skript støtter `code-insiders` via `--code-cmd code-insiders` (bash) / `-CodeCmd code-insiders` (PowerShell).
