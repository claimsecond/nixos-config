# modules/hosts/nixos/default.nix
# Сборка nixosConfigurations.nixos из всех flake.nixosModules,
# объявленных в modules/system/ и modules/home/.

{ inputs, config, ... }: {
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules =
      # Все наши модули, собранные import-tree через flake.nixosModules.*
      (builtins.attrValues config.flake.nixosModules)
      ++ [
        # niri подключается отдельно — это внешний nixosModule из inputs
        inputs.niri.nixosModules.niri
      ];
  };
}
