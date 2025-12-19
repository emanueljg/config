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

    stylesets = lib.mkOption {
      type = with lib.types; nullOr (either attrsOf str);
    };

    needsAWrapper = lib.mkOption {
      type = lib.types.bool;
      default = builtins.any builtins.isNull [
        cfg.aercSettings
        cfg.bindsSettings
        cfg.accountsSettings
        cfg.stylesets
      ];
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = lib.optional (!cfg.needsAWrapper) cfg.package;

    local.wrap.wraps = lib.mkIf cfg.needsAWrapper {
      "aerc" = {
        pkg = cfg.package;
        systemPackages = true;
        bins."aerc" =

          # aerc.conf
          lib.optionalAttrs (cfg.aercSettings != null) {
            envs."XDG_CONFIG_HOME".paths."aerc/aerc.conf" = settingsFormat.generate "aerc.conf" cfg.aercSettings;
          } 

          # binds.conf
          // lib.optionalAttrs (cfg.bindsSettings != null) {
            envs."XDG_CONFIG_HOME".paths."aerc/binds.conf" = settingsFormat.generate "binds.conf" cfg.bindsSettings;
          } 

          # stylesets
          // lib.optionalAttrs (cfg.stylesets != null) (builtins.mapAttrs (n: v: 
            envs."XDG_CONFIG_HOME".paths."aerc/stylesets/${n}" = v) cfg.stylesets
          ) 

          # accounts.conf (secret out-of-store file arg
          // lib.optionalAttrs (cfg.accountsConfPath != null) {
            flags."--accounts-conf".verbatim = cfg.accountsConfPath;
          }; 
      };
    };
  };
}
