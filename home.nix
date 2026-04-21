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

  systemd.user.services.noctalia = {
    Unit.After = [ "graphical-session.target" ];
    Service = {
      # Мы явно указываем правильный путь к правильному файлу
      ExecStart = "${inputs.noctalia.packages.${pkgs.system}.default}/bin/noctalia-shell"; 
      Restart = "on-failure";
    };
}