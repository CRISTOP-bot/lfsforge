state_init(){ mkdir -p "$STATE_DIR/state"; STATE_FILE="$STATE_DIR/state/checkpoints.tsv"; touch "$STATE_FILE"; }
stage_start(){ local s="$1"; printf '%s\tRUNNING\t%s\n' "$s" "$(now)" >> "$STATE_FILE"; log "START $s"; }
stage_done(){ local s="$1"; printf '%s\tDONE\t%s\n' "$s" "$(now)" >> "$STATE_FILE"; log "DONE $s"; }
stage_fail(){ local s="$1"; printf '%s\tFAILED\t%s\n' "$s" "$(now)" >> "$STATE_FILE"; log "FAILED $s"; }
stage_done_already(){ awk -F '\t' -v s="$1" '$1==s&&$2=="DONE"{x=1} END{exit !x}' "$STATE_FILE"; }
state_report(){ echo; echo 'LFSForge checkpoints'; for s in host environment sources toolchain chroot system kernel grub validate; do stage_done_already "$s" && printf '[✓] %s\n' "$s" || printf '[ ] %s\n' "$s"; done; }
