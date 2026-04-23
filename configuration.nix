# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs,... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix 
    ./modules/audio.nix
    ./modules/xdg.nix 
    ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

  programs.niri = {
    enable = true;
    settings = {
      # настройки в формате Nix (KDL будет сгенерирован автоматически)
      # Пример:
      input.keyboard.xkb.layout = "us,ru";
      layout.gaps = 16;
      binds = {
        "Mod+T".action = "spawn 'alacritty'";
        "Mod+Q".action = "close-window";
      };
  };

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
    #  neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  git
    nirius
    alacritty
    adwaita-icon-theme
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true; 


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
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
