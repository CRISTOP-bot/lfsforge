toolchain_prepare(){ mkdir -p "$CFG_LFS_ROOT/tools"; cat > "$CFG_LFS_ROOT/tools/.lfsforge-info" <<EOF2
LFSForge temporary toolchain workspace
Architecture: $CFG_ARCHITECTURE
Jobs: $CFG_JOBS
Created: $(now)
EOF2
info 'Workspace de toolchain preparado; compilación de paquetes aún requiere el plan de la versión LFS.'; }
