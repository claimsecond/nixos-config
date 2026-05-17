# modules/default.nix
# Корневой flake-parts модуль. import-tree подхватит все .nix файлы
# в поддиректориях (nixos/, home/) как дополнительные flake-parts модули.

{ ... }: {
  systems = [ "x86_64-linux" ];
}
