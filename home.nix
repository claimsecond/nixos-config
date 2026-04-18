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
    dms-shell
    quickshell
    matugen
    brightnessctl
    pamixer
  ];

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true; # Нужно, если используете XWayland приложения
    package = pkgs.bibata-cursors; # Пакет с темой (например, Bibata)
    name = "Bibata-Modern-Classic"; # Точное название темы
    size = 24;
  };

  systemd.user.services.dms = {
    description = "DMS shell service";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.dms-shell}/bin/dms run";
      Restart = "on-failure";
    };
  };
}