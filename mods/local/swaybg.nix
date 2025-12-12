{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.local.services.swaybg;
in
{

  options.local.services.swaybg = {
    enable = lib.mkEnableOption "";
    package = lib.mkPackageOption pkgs "swaybg" { };
    settings = lib.mkOption {
      type = with lib.types; attrsOf anything;
      default = { };
    };
  };

  config = lib.mkIf cfg.enable {

    local.wrap.wraps."swaybg" = {
      pkg = cfg.package;
      bins."swaybg".envs."XDG_CONFIG_HOME".paths = {
        "hypr/swaybg.conf" = config.local.lib.toHyprConf { attrs = cfg.settings; };
      };
    };

    systemd.user.services.swaybg = {
      wantedBy = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];

      unitConfig.ConditionEnvironment = "WAYLAND_DISPLAY";

      serviceConfig = {
        ExecStart = lib.getExe config.local.wrap.wraps."swaybg".finalPackage;
        Restart = "always";
        RestartSec = "10";
      };
    };

  };
}
