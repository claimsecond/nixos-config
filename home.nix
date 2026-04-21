{ config, pkgs, ... }:

{
  imports = [
    ./modules/niri.nix
  ];

  home.username = "claim";
  home.homeDirectory = "/home/claim";

  home.stateVersion = "26.05"; # проверьте свою версию nixos

  programs.git.enable = true;

  home.packages = with pkgs; [
    git
    neovim
  ];

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true; # Нужно, если используете XWayland приложения
    package = pkgs.bibata-cursors; # Пакет с темой (например, Bibata)
    name = "Bibata-Modern-Classic"; # Точное название темы
    size = 24;
  };

  # Enable Noctalia user service via Home Manager
  noctalia = {
    enable = true;
    systemd = {
      enable = true; # create user service unit for noctalia
    };
    # other noctalia-specific options can go here
  };

}