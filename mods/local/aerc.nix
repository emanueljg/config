{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.local.aerc;
  settingsFormat = pkgs.formats.ini { };

  confOption = lib.mkOption {
    type = lib.types.nullOr settingsFormat.type;
    default = null;
  };
in
{
  options.local.aerc = {
    enable = lib.mkEnableOption "aerc";
    package = lib.mkPackageOption pkgs "aerc" { };

    aercSettings = confOption;
    bindsSettings = confOption;

    # https://tilde.club/~djhsu/aerc-gmail-oauth2.html
    # https://www.maths.tcd.ie/~fionn/misc/aerc/  <-- used script here
    accountsConfPath = lib.mkOption {
      type = with lib.types; nullOr str;
      default = null;
    };

    needsAWrapper = lib.mkOption {
      type = lib.types.bool;
      default = cfg.aercSettings != null || cfg.bindsSettings != null || cfg.accountsSettings != null;
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = lib.optional (!cfg.needsAWrapper) cfg.package;

    local.wrap.wraps = lib.mkIf cfg.needsAWrapper {
      "aerc" = {
        pkg = cfg.package;
        systemPackages = true;
        bins."aerc".flags =
          lib.optionalAttrs (cfg.aercSettings != null) {
            "--aerc-conf".path = settingsFormat.generate "aerc.conf" cfg.aercSettings;
          }
          // lib.optionalAttrs (cfg.bindsSettings != null) {
            "--binds-conf".path = settingsFormat.generate "binds.conf" cfg.bindsSettings;
          }
          // lib.optionalAttrs (cfg.accountsConfPath != null) {
            "--accounts-conf".verbatim = cfg.accountsConfPath;
          };
      };

    };
  };
}
