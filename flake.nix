# flake.nix
{
  description = "My NixOS system";

  inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; 
  niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
    };

  quickshell = {
      url = "github:noctalia-dev/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
    };
  };

  outputs = { self, nixpkgs, home-manager, niri, ... }@inputs:
  let
    system = "x86_64-linux";
    hostname = "nixos";
  in {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };

      modules = [
        ./configuration.nix 
        home-manager.nixosModules.home-manager 
        niri.nixosModules.niri 

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