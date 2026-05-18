# modules/home/vicinae/default.nix
# Flake-parts модуль: экспортирует декларативные настройки для Vicinae launcher через Home Manager.

{ ... }: {
  flake.homeModules.vicinae = { pkgs, ... }: {
    programs.vicinae = {
      enable = true;
      package = pkgs.vicinae;

      settings = {
        launcher_window = {
          # Использовать layer-shell для отображения поверх других окон в Wayland
          layer_shell = {
            enabled = true;
          };
        };
      };
    };
  };
}
