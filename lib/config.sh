#!/usr/bin/env bash
config_init(){ CONFIG_FILE="${CONFIG_FILE:-$STATE_DIR/config/build.yml}"; mkdir -p "$(dirname "$CONFIG_FILE")"; [[ -f "$CONFIG_FILE" ]] || config_defaults; }
config_defaults(){ CFG_ARCHITECTURE="$(uname -m)"; [[ "$CFG_ARCHITECTURE" == x86_64 ]] || CFG_ARCHITECTURE=x86_64; CFG_LFS_ROOT=/mnt/lfs; CFG_JOBS="$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo 1)"; CFG_PROFILE=standard; CFG_LFS_VERSION=unspecified; CFG_BOOTLOADER_ENABLED=false; CFG_BOOTLOADER_TYPE=grub; CFG_KERNEL_ENABLED=false; CFG_QEMU_ENABLED=false; CFG_SOURCES_DIR="$STATE_DIR/cache/sources"; }
config_load(){ local f="$1" line key val section=''; [[ -f "$f" ]] || die "Config no encontrada: $f"; config_defaults; CONFIG_FILE="$f"; while IFS= read -r line || [[ -n "$line" ]]; do line="${line%%#*}"; [[ -z "${line//[[:space:]]/}" ]] && continue; if [[ "$line" =~ ^([a-zA-Z_]+):[[:space:]]*$ ]]; then section="${BASH_REMATCH[1]}"; continue; fi; [[ "$line" != [[:space:]]* ]] && section=''; if [[ "$line" =~ ^[[:space:]]*([a-zA-Z_]+):[[:space:]]*(.*)$ ]]; then key="${BASH_REMATCH[1]}"; val="${BASH_REMATCH[2]}"; val="${val%\"}"; val="${val#\"}"; [[ -n "$section" ]] && key="${section}_${key}"; key="CFG_${key^^}"; printf -v "$key" '%s' "$val"; fi; done < "$f"; }
config_save(){ local f="${1:-$CONFIG_FILE}"; mkdir -p "$(dirname "$f")"; cat > "$f" <<YAML
# LFSForge configuration; version-specific package manifests are separate.
lfs_version: ${CFG_LFS_VERSION:-unspecified}
architecture: ${CFG_ARCHITECTURE}
lfs_root: ${CFG_LFS_ROOT}
jobs: ${CFG_JOBS}
profile: ${CFG_PROFILE}
bootloader:
  enabled: ${CFG_BOOTLOADER_ENABLED}
  type: ${CFG_BOOTLOADER_TYPE}
kernel:
  enabled: ${CFG_KERNEL_ENABLED}
qemu:
  enabled: ${CFG_QEMU_ENABLED}
sources_dir: ${CFG_SOURCES_DIR}
YAML
}
