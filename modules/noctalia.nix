{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = [
    inputs.noctalia.packages.${pkgs.system}.default
  ];

  # автозапуск через systemd user
  systemd.user.services.noctalia = {
    description = "Noctalia shell";
    wantedBy = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStart = "${inputs.noctalia.packages.${pkgs.system}.default}/bin/noctalia-shell";
      Restart = "always";
    };
  };
}