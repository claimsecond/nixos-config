{
  description = "My NixOS system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, quickshell, noctalia, ... } @ inputs:
  let
    system = "x86_64-linux";
    hostname = "nixos";
  in {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = { inherit inputs; }; # [cite: 38]

      modules = [
        ./configuration.nix

        home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup"; 
        # Теперь эта строка не будет выдавать ошибку
        home-manager.extraSpecialArgs = { inherit inputs; }; # [cite: 39]
        home-manager.users.claim = import ./home.nix;
        }
      ];
    };
  };
}