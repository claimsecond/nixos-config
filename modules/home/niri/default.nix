# modules/home/niri/default.nix
# Flake-parts модуль: экспортирует home-manager конфиг для niri.

{ ... }: {
  flake.homeModules.niri = { ... }: {
    xdg.configFile."niri/config.kdl".source = ./config.kdl;
  };
}
