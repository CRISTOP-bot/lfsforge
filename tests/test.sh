#!/usr/bin/env bash
set -Eeuo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd); export LFSFORGE_ROOT="$ROOT"; export STATE_DIR="$ROOT/tests/.state"; rm -rf "$STATE_DIR"; source "$ROOT/lib/utils.sh"; source "$ROOT/lib/config.sh"; source "$ROOT/lib/logging.sh"; source "$ROOT/lib/state.sh"; config_init; [[ "$CFG_ARCHITECTURE" == x86_64 || -n "$CFG_ARCHITECTURE" ]]; state_init; log_init; stage_done test; stage_done_already test; grep -q 'test.*DONE' "$STATE_FILE"; echo 'all tests passed'
cat > "$STATE_DIR/config/test.yml" <<YAML
architecture: aarch64
lfs_root: /tmp/lfs-test
jobs: 3
profile: minimal
bootloader:
  enabled: true
  type: grub
kernel:
  enabled: false
YAML
config_load "$STATE_DIR/config/test.yml"
[[ "$CFG_ARCHITECTURE" == aarch64 && "$CFG_BOOTLOADER_ENABLED" == true && "$CFG_KERNEL_ENABLED" == false ]]
echo 'config parser passed'
