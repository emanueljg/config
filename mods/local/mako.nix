{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.local.mako;
in
{
  options.local.mako = {
    enable = lib.mkEnableOption "mako";
    package = lib.mkPackageOption pkgs "mako" { };
    settings = lib.mkOption {
      type = with lib.types; attrsOf anything;
      default = { };
    };
  };
  config = lib.mkIf cfg.enable {
    local.wrap.wraps."mako" = {
      pkg = cfg.package;
      systemPackages = true;
      bins."mako".envs."XDG_CONFIG_HOME".paths = {
        "mako/config" = lib.mkIf (cfg.settings != { }) (
          lib.concatMapAttrsStringSep "\n" (n: v: "${n}=${builtins.toString v}") cfg.settings
        );
      };
    };
  };
}
