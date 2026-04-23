{ config, pkgs, inputs, ... }:

{
  imports = [
    ./modules/niri.nix 
  ];

  home.username = "claim";
  home.homeDirectory = "/home/claim";
  home.stateVersion = "26.05";

  programs.git.enable = true;

  home.packages = with pkgs; [
    git
    neovim 
    quickshell
  ];

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };
}