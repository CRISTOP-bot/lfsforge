# Stages

Cada etapa tiene un contrato: recibe la configuración cargada, escribe su log a través del motor y devuelve `0` solo cuando completó su trabajo. En el MVP, las etapas que ya tienen implementación son `environment`, `toolchain` y `validate`; `host` y `sources` viven en sus módulos especializados (`lib/checks.sh`, `lib/sources.sh`) porque también se usan directamente desde CLI.

Las etapas de chroot, system, kernel y grub no inventan recetas: deben implementarse contra un perfil de versión LFS y sus instrucciones oficiales.
