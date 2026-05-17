# modules/home/user.nix
# Plain home-manager модуль для пользователя claim.

{ config, pkgs, ... }:

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
