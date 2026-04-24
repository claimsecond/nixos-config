{ config, pkgs, inputs, ... }:

{
  imports = [
    ./modules/niri.nix 
  ];

  home.username = "claim";
  home.homeDirectory = "/home/claim";
  home.stateVersion = "26.05";

  programs.git.enable = true; 
  programs.niri = {
  enable = true;
  settings = {
    prefer-no-csd = true;
    input.keyboard.xkb = {
      layout = "us";
      variant = "intl";
    };
    layout = {
      gaps = 4;
      focus-ring = {
        enable = true;
        width = 2;
        active.color = "#${config.colorScheme.palette.base0D}ff";
        inactive.color = "#${config.colorScheme.palette.base03}ff";
        };
      };
    };
  };

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