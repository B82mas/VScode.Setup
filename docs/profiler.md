# VS Code-profiler

VS Code-profiler lar deg bytte mellom sett av extensions, innstillinger og layout uten å blande dem. Opprett via `Ctrl+Shift+P` → **Profiles: Create Profile**.

## 1. `Dev — Fullstack`
Kode, web, TypeScript/React, generell scripting.
- Extensions: ESLint, Prettier, Tailwind CSS, Prisma, GitLens, Error Lens
- Tema: One Dark Pro / GitHub Dark Default
- Layout: Terminal nederst, Explorer + Source Control til venstre

## 2. `Sikkerhet & OT/ICS`
Pentest-notater, DFIR, sjekklister, hex/binæranalyse.
- Extensions: Hex Editor, cSpell, Todo Tree, Markdown All in One
- Tema: mørkt, høykontrast (f.eks. Monokai eller GitHub Dark High Contrast)
- Ekstra: sett `files.exclude` til å skjule store binærfiler/samples

## 3. `Cloud & Infrastruktur`
Terraform, Kubernetes, Docker, Bicep, CI/CD.
- Extensions: Terraform, Kubernetes Tools, Docker, YAML, GitHub Actions, Bicep
- Tema: Nord eller Night Owl (god kontrast for YAML/HCL)

## 4. `Dokumentasjon & Wiki`
Markdown-tunge oppgaver: rapporter, ADR-er, prosjektnotater.
- Extensions: Foam, Markdown All in One, Markdown Preview Enhanced, Mermaid, markdownlint, cSpell (nb+en)
- Innstillinger: `editor.wordWrap: on`, minimap av, større skrift (16px), fokus-modus (`Zen Mode`, `Ctrl+K Z`)
- Tema: lyst tema anbefales for lengre lesing (f.eks. GitHub Light eller Solarized Light)

## 5. `IoT & Embedded`
ESP32/Raspberry Pi-firmware.
- Extensions: PlatformIO IDE, C/C++ Extension Pack
- Ekstra: PlatformIO gir egen device-monitor/serial-logging integrert

## Praktisk tips
- Bind hver profil til et bestemt vindu/workspace: åpne riktig mappe fra `mappestruktur.md` og velg profil i statuslinjen nederst til venstre.
- Eksporter profiler (**Profiles: Export Profile**) og lagre som `.code-profile`-filer i denne repoen under `profiles/` for versjonskontroll og gjenbruk på ny maskin.
