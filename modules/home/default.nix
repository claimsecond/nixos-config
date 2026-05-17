# modules/home/default.nix
# Flake-parts модуль: оборачивает home-manager конфиг в nixosModules.home.

{ inputs, ... }: {
  flake.nixosModules.home = { ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager.useGlobalPkgs   = true;
    home-manager.useUserPackages = true;
    home-manager.users.claim     = import ./user.nix;
  };
}
