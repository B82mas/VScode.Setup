#!/usr/bin/env bash
#
# VS Code setup-script (Linux/macOS)
# Installerer anbefalte extensions og kopierer felles settings inn i VS Code User-profilen.
#
# Bruk:
#   ./scripts/setup.sh
#   ./scripts/setup.sh --code-cmd code-insiders   # hvis du bruker Insiders
#   ./scripts/setup.sh --dry-run                  # bare vis hva som ville skjedd
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

CODE_CMD="code"
DRY_RUN=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --code-cmd)
      CODE_CMD="$2"
      shift 2
      ;;
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    -h|--help)
      grep '^#' "$0" | sed 's/^# \{0,1\}//'
      exit 0
      ;;
    *)
      echo "Ukjent flagg: $1" >&2
      exit 1
      ;;
  esac
done

log() { printf '\033[1;34m[setup]\033[0m %s\n' "$1"; }
run() {
  if $DRY_RUN; then
    echo "  (dry-run) $*"
  else
    "$@"
  fi
}

# --- 1. Installer VS Code selv, hvis det ikke allerede finnes ---
install_vscode() {
  log "Fant ikke '$CODE_CMD' — installerer VS Code..."
  case "$(uname -s)" in
    Linux)
      if command -v apt >/dev/null 2>&1; then
        log "Installerer VS Code via apt (Microsoft sitt repo)"
        run sudo apt-get update -y
        run sudo apt-get install -y wget gpg apt-transport-https
        TMP_KEY="$(mktemp)"
        run bash -c "wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > '$TMP_KEY'"
        run sudo install -D -o root -g root -m 644 "$TMP_KEY" /usr/share/keyrings/packages.microsoft.gpg
        run bash -c "echo 'deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main' | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null"
        run sudo apt-get update -y
        run sudo apt-get install -y code
      elif command -v snap >/dev/null 2>&1; then
        log "Installerer VS Code via snap"
        run sudo snap install code --classic
      elif command -v dnf >/dev/null 2>&1; then
        log "Installerer VS Code via dnf"
        run sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
        run bash -c "printf '[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc\n' | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null"
        run sudo dnf check-update -y || true
        run sudo dnf install -y code
      else
        echo "Fant verken apt, snap eller dnf. Installer VS Code manuelt: https://code.visualstudio.com/download" >&2
        exit 1
      fi
      ;;
    Darwin)
      if command -v brew >/dev/null 2>&1; then
        log "Installerer VS Code via Homebrew"
        run brew install --cask visual-studio-code
      else
        echo "Fant ikke Homebrew. Installer VS Code manuelt: https://code.visualstudio.com/download" >&2
        exit 1
      fi
      ;;
    *)
      echo "Ukjent OS. Installer VS Code manuelt: https://code.visualstudio.com/download" >&2
      exit 1
      ;;
  esac
}

if ! command -v "$CODE_CMD" >/dev/null 2>&1; then
  install_vscode
fi

if ! $DRY_RUN && ! command -v "$CODE_CMD" >/dev/null 2>&1; then
  echo "Installasjonen fullførte, men fant fortsatt ikke '$CODE_CMD' i PATH." >&2
  echo "Åpne en ny terminal, eller åpne VS Code og kjør 'Shell Command: Install code command in PATH' fra Command Palette." >&2
  exit 1
fi
log "Bruker VS Code CLI: $(command -v "$CODE_CMD" || echo "$CODE_CMD (dry-run, ikke installert enda)")"

# --- 2. Finn riktig User-mappe for settings/keybindings ---
case "$(uname -s)" in
  Darwin)
    USER_DIR="$HOME/Library/Application Support/Code/User"
    ;;
  Linux)
    USER_DIR="$HOME/.vscode"
    ;;
  *)
    echo "Ukjent OS for automatisk User-mappe. Kopier settings/keybindings manuelt." >&2
    USER_DIR=""
    ;;
esac

# --- 3. Installer anbefalte extensions ---
EXT_FILE="$REPO_ROOT/.vscode/extensions.json"
if [[ -f "$EXT_FILE" ]]; then
  log "Leser anbefalte extensions fra $EXT_FILE"
  # Strip // og /* */ kommentarer (JSONC) før parsing med grep/sed, siden filen er kommentert
  EXTENSIONS=$(sed -e 's#//.*##' "$EXT_FILE" | grep -oE '"[a-zA-Z0-9._-]+\.[a-zA-Z0-9._-]+"' | tr -d '"' | sort -u)
  if [[ -z "$EXTENSIONS" ]]; then
    log "Fant ingen extensions å installere."
  else
    while IFS= read -r ext; do
      log "Installerer extension: $ext"
      run "$CODE_CMD" --install-extension "$ext" --force
    done <<< "$EXTENSIONS"
  fi
else
  log "Fant ikke $EXT_FILE — hopper over extension-installasjon."
fi

# --- 4. Kopier/merge settings.json inn i User-profilen ---
if [[ -n "$USER_DIR" ]]; then
  mkdir -p "$USER_DIR"
  SRC_SETTINGS="$REPO_ROOT/.vscode/settings.json"
  DEST_SETTINGS="$USER_DIR/settings.json"

  if [[ -f "$SRC_SETTINGS" ]]; then
    if [[ -f "$DEST_SETTINGS" ]]; then
      BACKUP="$DEST_SETTINGS.bak.$(date +%Y%m%d%H%M%S)"
      log "Eksisterende settings.json funnet — tar backup til $BACKUP"
      run cp "$DEST_SETTINGS" "$BACKUP"
    fi
    log "Kopierer settings.json til $DEST_SETTINGS"
    run cp "$SRC_SETTINGS" "$DEST_SETTINGS"
  fi
else
  log "Ukjent OS: kopier $REPO_ROOT/.vscode/settings.json manuelt til din VS Code User-mappe."
fi

log "Ferdig! Åpne hovedarbeidsmappen din i VS Code og velg ønsket profil/tema."
