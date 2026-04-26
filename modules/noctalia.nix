# modules/noctalia.nix 
# пока отключил, т.к. подключил через spawn-at-startup "noctalia-shell"

{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = [
    inputs.noctalia.packages.${pkgs.system}.default
  ];

  systemd.user.services.noctalia = {
    description = "Noctalia shell";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${inputs.noctalia.packages.${pkgs.system}.default}/bin/noctalia";  # уточните имя бинарника: может быть "noctalia" или "noctalia-shell"
      Restart = "always";
      RestartSec = 5;
    };
  };
}