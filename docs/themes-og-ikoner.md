# Tema, ikoner og font

## Tema-forslag

| Bruk | Tema | Extension |
|---|---|---|
| Koding (standard) | **One Dark Pro** eller **GitHub Dark Default** | `zhuangtongfa.material-theme` / `github.github-vscode-theme` |
| Infrastruktur/YAML/HCL | **Night Owl** | `sdras.night-owl` |
| Dokumentasjon/lesing | **GitHub Light** eller **Solarized Light** | `github.github-vscode-theme` |
| Høy kontrast (sikkerhet/lange sesjoner) | **Monokai Pro** eller innebygd *Dark High Contrast* | — |

Sett gjerne opp automatisk lys/mørk-bytte etter system:
```json
"window.autoDetectColorScheme": true,
"workbench.preferredDarkColorTheme": "GitHub Dark Default",
"workbench.preferredLightColorTheme": "GitHub Light Default"
```

## Ikoner

- **Material Icon Theme** (`pkief.material-icon-theme`) — bredt språkstøtte, tydelig skille mellom kode/config/dokument-filer, god for blandede prosjekter (kode + docs + IaC).

## Font

- **JetBrains Mono** eller **Fira Code** — begge har ligaturer (`=>`, `!=` osv.) som gjør TypeScript/Python/Terraform lettere å lese.
- For markdown/dokumentasjon: behold samme monospace-font, men øk `editor.fontSize` til 15–16 i `Dokumentasjon & Wiki`-profilen for bedre leselighet.

## Statuslinje-anbefaling

Bruk farge på statuslinjen per profil (`workbench.colorCustomizations` → `statusBar.background`) så du visuelt ser hvilken profil/kontekst du er i, f.eks.:
- Dev — blå
- Sikkerhet — rød
- Cloud/Infra — grønn
- Dokumentasjon — grå/nøytral
