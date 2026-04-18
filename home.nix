{ config, pkgs, ... }:

{
  home.username = "claim";
  home.homeDirectory = "/home/claim";

  home.stateVersion = "26.05"; # проверьте свою версию nixos

  programs.git.enable = true;

  home.packages = with pkgs; [
    git
    neovim
  ];

  xdg.configFile."niri/config.kdl".text = ''
    input {
      keyboard {
        xkb {
          layout "us"
        }
      }
    }

    binds {
      Super+T { spawn "alacritty"; }
    }
  '';
}