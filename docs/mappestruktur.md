# Forslag til mappestruktur

Tanken er én **hovedmappe** (f.eks. `~/B82MAS/` eller `D:\B82MAS\`) som åpnes som *multi-root workspace* i VS Code, med undermapper per fagområde. Dette gjør at kode, dokumentasjon og wiki lever side om side, men holdes ryddig atskilt for git-formål (hvert prosjekt = eget repo der det gir mening).

```
B82MAS/
├── 00-wiki/                  # Personlig/team-wiki (Foam/Markdown, sammenkoblede notater)
│   ├── daglig/                # Daglige notater (journal-stil)
│   ├── prosjekter/             # Notater knyttet til enkeltprosjekter
│   └── referanser/             # Snarveier, sjekklister, kommandoer
│
├── 01-dokumentasjon/         # Rapporter, ADR-er, tekniske memoer (docx/pptx/xlsx/pdf-output havner her)
│   ├── arkitektur/             # C4-diagrammer, ADR-er
│   ├── sikkerhet/              # Pentest-rapporter, DFIR-notater, sjekklister
│   └── prosjektledelse/        # Charter, WBS, statusrapporter
│
├── 02-kode/                  # Aktive kodeprosjekter, ett repo per undermappe
│   ├── web/                    # Fullstack (React/Next.js/TS)
│   ├── automasjon/             # Python/PowerShell-scripting
│   ├── iot/                    # ESP32/Raspberry Pi-firmware
│   └── sikkerhet-verktoy/      # Egne security-tools/scripts
│
├── 03-infrastruktur/         # IaC og drift
│   ├── terraform/
│   ├── kubernetes/
│   └── docker-compose/
│
├── 04-arkiv/                  # Avsluttede/pausede prosjekter
│
└── .vscode/                   # Workspace-fil + felles settings/extensions (denne repoen)
```

## Multi-root workspace

Lag en `.code-workspace`-fil i roten av `B82MAS/` som limer sammen de viktigste mappene:

```json
{
  "folders": [
    { "name": "📓 Wiki", "path": "00-wiki" },
    { "name": "📄 Dokumentasjon", "path": "01-dokumentasjon" },
    { "name": "💻 Kode", "path": "02-kode" },
    { "name": "☁️ Infrastruktur", "path": "03-infrastruktur" }
  ],
  "settings": {}
}
```

Da slipper du å ha alt i én stor mappe, men ser det samlet i Explorer med tydelige ikoner/navn per seksjon.

## Wiki-anbefaling

For `00-wiki/` er **Foam** (extension `foam.foam-vscode`) et godt valg: ren Markdown, wiki-lenker (`[[notat]]`), graf-visning og daglige notater — alt lagres som filer du selv eier (ingen lock-in), og synkroniseres fint med git.
