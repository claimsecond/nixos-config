# modules/home/default.nix
# Flake-parts модуль: собирает home-manager конфиг пользователя claim
# через flake.nixosModules.home, используя все flake.homeModules.*.

{ inputs, config, ... }: {
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  flake.nixosModules.home = { ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager.useGlobalPkgs   = true;
    home-manager.useUserPackages = true;
    home-manager.users.claim     = { pkgs, ... }: {
      imports = builtins.attrValues config.flake.homeModules;

      home.username      = "claim";
      home.homeDirectory = "/home/claim";
      home.stateVersion  = "26.05";

      programs.git.enable = true;

      home.packages = with pkgs; [
        git
        neovim
        firefox
      ];

      home.pointerCursor = {
        gtk.enable = true;
        package    = pkgs.bibata-cursors;
        name       = "Bibata-Modern-Classic";
        size       = 24;
      };
    };
  };
}
