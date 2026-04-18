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

  home.sessionVariables = {
    XCURSOR_SIZE = "14";
    XCURSOR_THEME = "Adwaita";
  };
}