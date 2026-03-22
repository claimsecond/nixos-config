{ config, pkgs, ... }:

{
  services.xdg.portal.enable = true;
  services.xdg.portal.xdgOpenUsePortal = true;
  services.xdg.portal.config.common.default = "*";
  services.xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}