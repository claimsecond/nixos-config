# modules/home/default.nix
# Точка входа для home-manager конфигурации пользователя claim.
# Импортируется из modules/nixos/default.nix как:
#   home-manager.users.claim = import ../home;

{ config, pkgs, inputs, ... }:

{
  imports = [
    ./niri.nix
  ];

  home.username      = "claim";
  home.homeDirectory = "/home/claim";

  home.stateVersion = "26.05";

  programs.git.enable = true;

  home.packages = with pkgs; [
    git
    neovim
    firefox
  ];

  home.pointerCursor = {
    gtk.enable = true;
    package    = pkgs.bibata-cursors;
    name       = "Bibata-Modern-Classic";
    size       = 24;
  };
}
