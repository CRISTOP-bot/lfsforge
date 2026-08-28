log_init(){ mkdir -p "$STATE_DIR"/{logs,state,config,cache}; LOG_FILE="$STATE_DIR/logs/main.log"; : > /dev/null; }
stage_log(){ printf '%s/logs/%s.log' "$STATE_DIR" "$1"; }
log(){ printf '[%s] %s\n' "$(now)" "$*" | tee -a "$LOG_FILE"; }
