# modules/home/vicinae/default.nix
# Flake-parts модуль: экспортирует декларативные настройки для Vicinae launcher через Home Manager.

{ ... }: {
  flake.homeModules.vicinae = { ... }: {
    programs.vicinae = {
      enable = true;
    };

    xdg.configFile."vicinae/settings.json".source = ./settings.json;
  };
}
