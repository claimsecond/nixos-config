{
  description = "My NixOS system";

  inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
    };

  dms = {
    url = "github:AvengeMedia/DankMaterialShell/stable";
    inputs.nixpkgs.follows = "nixpkgs";
    }; 
  niri.url = "github:YaLTeR/niri";
  };

  outputs = { self, nixpkgs, home-manager, dms, ... }@inputs:
  let
    system = "x86_64-linux";
    hostname = "nixos";
  in {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };

      modules = [
        ./configuration.nix 
        dms.nixosModules.default
        home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup"; 
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.claim = import ./home.nix;
        }
      ];
    };
  };
}