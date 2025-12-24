{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.local.udiskie;
in
{
  options.local.udiskie = {
    enable = lib.mkEnableOption "udiskie";
    package = lib.mkPackageOption pkgs "udiskie" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
    systemd.user.services."udiskie" = {
      wantedBy = [ "default.target" ];

      serviceConfig.ExecStart = lib.getExe cfg.package;
    };
  };
}
