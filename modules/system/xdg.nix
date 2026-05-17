# modules/system/xdg.nix

{ ... }: {
  flake.nixosModules.xdg = { pkgs, ... }: {
    xdg.portal = {
      enable             = true;
      xdgOpenUsePortal   = true;
      config.common.default = "*";
      extraPortals       = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}
