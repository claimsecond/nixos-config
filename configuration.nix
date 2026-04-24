# configuration.nix

{ config, pkgs, inputs,... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix 
    ./modules/audio.nix
    ./modules/xdg.nix 
    ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 
  nix.settings = {
  substituters = [
    "https://cache.nixos.org"
    "https://niri.cachix.org"
    "https://vicinae.cachix.org"
    ];
  trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
    ];
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Kyiv";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "uk_UA.UTF-8";
    LC_IDENTIFICATION = "uk_UA.UTF-8";
    LC_MEASUREMENT = "uk_UA.UTF-8";
    LC_MONETARY = "uk_UA.UTF-8";
    LC_NAME = "uk_UA.UTF-8";
    LC_NUMERIC = "uk_UA.UTF-8";
    LC_PAPER = "uk_UA.UTF-8";
    LC_TELEPHONE = "uk_UA.UTF-8";
    LC_TIME = "uk_UA.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  programs.niri.enable = true;

  services.xserver.enable = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.claim = {
    isNormalUser = true;
    description = "claim";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alacritty
    adwaita-icon-theme
    inputs.noctalia.packages.${pkgs.system}.default
  ];

  system.stateVersion = "25.11"; # Did you read the comment?

  # VMware
  virtualisation.vmware.guest.enable = true;

  # Disk
  services.fstrim.enable = true;

  # Nix optimisation
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  }; 
  systemd.services.nix-gc.serviceConfig = {
  IOSchedulingClass = "idle";
  CPUSchedulingPolicy = "idle";
  Nice = 19;
};

  nix.settings.auto-optimise-store = true;

  # Memory (если мало RAM)
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };


  # Disable unnecessary services
  services.printing.enable = false;
  services.avahi.enable = false;
  hardware.bluetooth.enable = false; 

  services.udev.extraRules = ''
  ACTION=="add|change", KERNEL=="sda", ATTR{queue/rotational}="0"
  '';
  services.dbus.enable = true;
}
