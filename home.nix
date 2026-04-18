{ config, pkgs, ... }:

{
  imports = [
    ./modules/niri.nix 
    inputs.dms.homeModules.dank-material-shell 
    inputs.niri.homeModules.niri
  ];

  home.username = "claim";
  home.homeDirectory = "/home/claim";

  home.stateVersion = "26.05"; # проверьте свою версию nixos

  programs.git.enable = true; 
  programs.dank-material-shell = {
  enable = true; 
  quickshell.package = pkgs.quickshell;

  systemd = {
    enable = true;             # Systemd service for auto-start
    restartIfChanged = true;   # Auto-restart dms.service when dank-material-shell changes
  };

  # Core features
  enableSystemMonitoring = true;     # System monitoring widgets (dgop)
  enableVPN = true;                  # VPN management widget
  enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
  enableAudioWavelength = true;      # Audio visualizer (cava)
  enableCalendarEvents = true;       # Calendar integration (khal)
  enableClipboardPaste = true;       # Pasting items from the clipboard (wtype)
};

  home.packages = with pkgs; [
    git
    neovim
    dms-shell
    quickshell
    matugen
    brightnessctl
    pamixer 
    cava
    dgop
  ];

  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true; # Нужно, если используете XWayland приложения
    package = pkgs.bibata-cursors; # Пакет с темой (например, Bibata)
    name = "Bibata-Modern-Classic"; # Точное название темы
    size = 24;
  };
}