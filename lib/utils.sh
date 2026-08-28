#!/usr/bin/env bash
COLOR=${COLOR:-1}; : "${LFSFORGE_ROOT:=$(pwd)}"; : "${STATE_DIR:=${XDG_STATE_HOME:-$HOME/.local/state}/lfsforge}"
info(){ printf '%s\n' "[INFO] $*"; }; warn(){ printf '%s\n' "[WARN] $*" >&2; }; error(){ printf '%s\n' "[ERROR] $*" >&2; }; die(){ error "$*"; exit 1; }
require_cmd(){ command -v "$1" >/dev/null 2>&1 || { warn "Falta dependencia: $1"; return 1; }; }
require_root_for_mounts(){ (( EUID == 0 )) || die 'Esta operación requiere privilegios. Ejecuta con sudo.'; }
require_confirm(){ local q="$1" a; printf '%s\n' "PELIGRO: $q"; read -r -p 'Escribe exactamente YES para continuar: ' a; [[ "$a" == YES ]] || die 'Operación cancelada'; }
now(){ date -Is; }
