{ config, pkgs, inputs, ... }:

{
  imports = [
    ./modules/niri.nix 
    inputs.niri.homeModules.niri
  ];

  home.username = "claim";
  home.homeDirectory = "/home/claim";

  home.stateVersion = "26.05"; # проверьте свою версию nixos

  programs.git.enable = true; 

};

  home.packages = with pkgs; [
    git
    neovim 
    quickshell
  ];

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true; # Нужно, если используете XWayland приложения
    package = pkgs.bibata-cursors; # Пакет с темой (например, Bibata)
    name = "Bibata-Modern-Classic"; # Точное название темы
    size = 24;
  };
}