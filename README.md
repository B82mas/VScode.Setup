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
2. Installer extensions fra `.vscode/extensions.json` (VS Code spør automatisk: "Install Recommended Extensions").
3. Sett opp profilene i `docs/profiler.md` (`Ctrl+Shift+P` → *Profiles: Create Profile*).
4. Velg tema fra `docs/themes-og-ikoner.md`.
