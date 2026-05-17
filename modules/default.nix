# modules/default.nix
# Корневой flake-parts модуль.
# import-tree сканирует только эту директорию — здесь только flake-parts модули.

{ ... }: {
  systems = [ "x86_64-linux" ];
}
