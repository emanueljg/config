{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.local.isync;
in
{
  options.local.isync = with lib.types; {
    enable = lib.mkEnableOption "isync";

    package = lib.mkPackageOption pkgs "isync" { };

    settings = lib.mkOption {
      default = null;
      type = with lib.types; nullOr (attrsOf (attrsOf (attrsOf ((either str int)))));
    };

    needsAWrapper = lib.mkOption {
      type = lib.types.bool;
      default = cfg.settings != null;
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = lib.optional (!cfg.needsAWrapper) cfg.package;
    local.wrap.wraps = lib.mkIf cfg.needsAWrapper {
      "isync" = {
        pkg = cfg.package;
        systemPackages = true;
        bins."mbsync".flags."--config".path = lib.concatMapAttrsStringSep "\n" (
          sectionStartName: section:
          lib.concatMapAttrsStringSep "\n" (sectionName: sectionValues: ''
            ${sectionStartName} ${sectionName}
            ${lib.concatMapAttrsStringSep "\n" (
              valueName: valueValue: "${valueName} ${builtins.toString valueValue}"
            ) sectionValues}
          '') section
        ) cfg.settings;
      };
    };
  };
}
