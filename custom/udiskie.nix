{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.custom.services.udiskie;
in
{
  options.custom.services.udiskie = {
    enable = lib.mkEnableOption "udiskie";
    package = lib.mkPackageOption pkgs "udiskie" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    systemd.user.services."udiskie" = {
      wantedBy = [ "default.target" ];

      serviceConfig.ExecStart = lib.getExe' cfg.package "udiskie";
    };
  };
}
