# Nyttige tastatursnarveier å legge til

Åpne `keybindings.json` via `Ctrl+Shift+P` → **Preferences: Open Keyboard Shortcuts (JSON)**.

```json
[
  { "key": "ctrl+k z", "command": "workbench.action.toggleZenMode" },
  { "key": "ctrl+alt+p", "command": "workbench.action.showProfiles" },
  { "key": "ctrl+shift+e", "command": "workbench.view.explorer" },
  { "key": "ctrl+shift+m", "command": "markdown.showPreviewToSide", "when": "editorLangId == markdown" },
  { "key": "ctrl+alt+w", "command": "workbench.action.selectTheme" },
  { "key": "ctrl+alt+t", "command": "workbench.action.terminal.toggleTerminal" }
]
```

- `Ctrl+K Z` — Zen Mode, nyttig for lengre skriveøkter (dokumentasjon/wiki).
- `Ctrl+Alt+P` — rask bytte mellom profiler.
- `Ctrl+Shift+M` — side-om-side markdown-forhåndsvisning.
