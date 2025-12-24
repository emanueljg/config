{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.local.aerc;
  settingsFormat = pkgs.formats.ini { };
  settingsFormat' = pkgs.formats.iniWithGlobalSection { };

  confOption = lib.mkOption {
    type = lib.types.nullOr settingsFormat.type;
    default = null;
  };
  confOption' = lib.mkOption {
    type = lib.types.nullOr settingsFormat'.type;
    default = null;
  };
in
{
  options.local.aerc = {
    enable = lib.mkEnableOption "aerc";
    package = lib.mkPackageOption pkgs "aerc" { };
    finalPackage = lib.mkOption {
      readOnly = true;
      type = lib.types.package;
      default = cfg.package.overrideAttrs (prevAttrs: {
        patches = (prevAttrs.patches or [ ]) ++ [
          ./xdg-folder-map.patch
        ];
      });
    };

    aercSettings = confOption;
    bindsSettings = confOption';

    # https://tilde.club/~djhsu/aerc-gmail-oauth2.html
    # https://www.maths.tcd.ie/~fionn/misc/aerc/  <-- used script here
    accountsConfPath = lib.mkOption {
      type = with lib.types; nullOr str;
      default = null;
    };

    folderMap = lib.mkOption {
      type = with lib.types; nullOr (attrsOf str);
      default = null;
    };

    stylesets = lib.mkOption {
      type = with lib.types; nullOr (attrsOf lines);
      default = null;
    };

    needsAWrapper = lib.mkOption {
      type = lib.types.bool;
      default = builtins.any (x: x != null) [
        cfg.aercSettings
        cfg.bindsSettings
        cfg.accountsConfPath
        cfg.folderMap
        cfg.stylesets
      ];
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = lib.optional (!cfg.needsAWrapper) cfg.finalPackage;

    local.wrap.wraps = lib.mkIf cfg.needsAWrapper {
      "aerc" = {
        pkg = cfg.finalPackage;
        systemPackages = true;
        bins."aerc" = builtins.foldl' lib.recursiveUpdate { } [

          # aerc.conf
          (lib.optionalAttrs (cfg.aercSettings != null) {
            envs."XDG_CONFIG_HOME".paths."aerc/aerc.conf" =
              settingsFormat.generate "aerc.conf" cfg.aercSettings;
          })

          # binds.conf
          (lib.optionalAttrs (cfg.bindsSettings != null) {
            envs."XDG_CONFIG_HOME".paths."aerc/binds.conf" =
              settingsFormat'.generate "binds.conf" cfg.bindsSettings;
          })

          # folder-map
          (lib.optionalAttrs (cfg.folderMap != null) {
            envs."XDG_CONFIG_HOME".paths."aerc/folder-map" = lib.generators.toKeyValue { } cfg.folderMap;
          })

          # stylesets
          (lib.optionalAttrs (cfg.stylesets != null) {
            envs."XDG_CONFIG_HOME".paths = lib.mapAttrs' (
              n: v: lib.nameValuePair "aerc/stylesets/${n}" v
            ) cfg.stylesets;
          })

          # accounts.conf (secret out-of-store file arg)
          (lib.optionalAttrs (cfg.accountsConfPath != null) {
            flags."--accounts-conf".verbatim = cfg.accountsConfPath;
          })
        ];
      };
    };
  };
}
