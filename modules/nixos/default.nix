# modules/nixos/default.nix
# Flake-parts модуль, объявляющий nixosConfigurations.

{ inputs, ... }: {
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      # Внешние NixOS-модули из inputs
      inputs.niri.nixosModules.niri

      # Home Manager как NixOS модуль
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs   = true;
        home-manager.useUserPackages = true;
        home-manager.users.claim     = import ../home;
      }

      # Системные модули
      ./hardware-configuration.nix
      ./configuration.nix
      ./audio.nix
      ./xdg.nix
    ];
  };
}
