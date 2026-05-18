# modules/system/configuration.nix

{ ... }: {
  flake.nixosModules.configuration = { config, pkgs, inputs, ... }: {
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
      trusted-users = [ "root" "@wheel" ];
    };

    # Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Latest kernel
    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "nixos";
    networking.networkmanager.enable = true;

    time.timeZone = "Europe/Kyiv";

    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS        = "uk_UA.UTF-8";
      LC_IDENTIFICATION = "uk_UA.UTF-8";
      LC_MEASUREMENT    = "uk_UA.UTF-8";
      LC_MONETARY       = "uk_UA.UTF-8";
      LC_NAME           = "uk_UA.UTF-8";
      LC_NUMERIC        = "uk_UA.UTF-8";
      LC_PAPER          = "uk_UA.UTF-8";
      LC_TELEPHONE      = "uk_UA.UTF-8";
      LC_TIME           = "uk_UA.UTF-8";
    };

    services.xserver.xkb = {
      layout  = "us";
      variant = "";
    };

    programs.niri.enable    = true;
    programs.xwayland.enable = true;
    services.xserver.enable  = false;

    users.users.claim = {
      isNormalUser = true;
      description  = "claim";
      extraGroups  = [ "networkmanager" "wheel" ];
      packages     = with pkgs; [];
    };

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      alacritty
      adwaita-icon-theme
      inputs.noctalia.packages.${pkgs.system}.default
      nixos-icons
      vicinae
    ];

    system.stateVersion = "25.11";

    # VMware
    virtualisation.vmware.guest.enable = true;

    # Disk
    services.fstrim.enable = true;

    # Nix optimisation
    nix.gc = {
      automatic = true;
      dates     = "weekly";
      options   = "--delete-older-than 7d";
    };
    systemd.services.nix-gc.serviceConfig = {
      IOSchedulingClass   = "idle";
      CPUSchedulingPolicy = "idle";
      Nice                = 19;
    };

    nix.settings.auto-optimise-store = true;

    # Memory
    zramSwap = {
      enable        = true;
      memoryPercent = 50;
    };

    # Disable unnecessary services
    services.printing.enable  = false;
    services.avahi.enable     = false;
    hardware.bluetooth.enable = false;

    services.udev.extraRules = ''
      ACTION=="add|change", KERNEL=="sda", ATTR{queue/rotational}="0"
    '';

    services.dbus.enable = true;
  };
}
