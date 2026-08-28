# LFSForge

LFSForge es una base modular de CLI/TUI para construir Linux From Scratch de forma guiada, inspeccionable y reproducible. **No es un instalador genérico ni oculta comandos.** La selección de paquetes y recetas debe provenir de la edición oficial de LFS indicada por `lfs_version`.

## MVP implementado

- CLI y TUI con `dialog` opcional (fallback CLI).
- Validación real del host, sin cambios en el sistema.
- Configuración YAML sencilla, perfiles y checkpoints persistentes.
- Logs por etapa, reanudación y limpieza con confirmación fuerte.
- Sources con descarga, reintentos, caché, detección de existentes y SHA256.
- Preparación segura del árbol LFS y workspace de toolchain.
- Validación inicial del árbol.
- Interfaces preparadas para kernel, GRUB, chroot y QEMU.

## Instalación y uso

```sh
cd lfsforge
sudo ./lfsforge              # TUI; dialog mejora la experiencia
./lfsforge configure
./lfsforge check
./lfsforge build --config ~/.local/state/lfsforge/config/build.yml
./lfsforge status
./lfsforge resume
./lfsforge logs
```

`build` requiere que el usuario pueda escribir `lfs_root`; no particiona, formatea ni borra discos. `shell` exige root y actualmente abre chroot solo sobre un entorno ya preparado; los montajes se mantienen explícitos y pendientes de la receta versionada.

## Configuración

El parser acepta claves simples y una sección anidada de un nivel. `lfs_version` es obligatoria para descargar sources: crea `lfs-versions/<versión>.manifest` con `nombre<TAB>URL<TAB>SHA256`, usando exclusivamente datos oficiales. Un hash `-` se permite solo para inspección y genera advertencia.

## Arquitectura

`lfsforge` despacha comandos; `lib/` contiene configuración, estado, logs, checks, sources y TUI; `stages/` contiene etapas aisladas; `profiles/` contiene perfiles; `tests/` contiene pruebas Bash.

## Seguridad

No hay operaciones automáticas de disco. `clean` exige escribir `YES`. Las etapas pendientes de recetas oficiales no inventan comandos: fallan o dejan una advertencia explícita. Antes de una compilación real hay que fijar versión, arquitectura, manifest y recetas oficiales compatibles.

## Pendiente

Compilación completa del toolchain y system, chroot con montajes controlados, kernel/GRUB reales, generación ISO/IMG, QEMU automatizado, ayuda F1, modo manual/avanzado, perfiles con paquetes y suite de pruebas más amplia. La estructura permite añadirlos por versión sin reescribir el dispatcher.

## Tests

```sh
./tests/test.sh
bash -n lfsforge lib/*.sh stages/*.sh
```
