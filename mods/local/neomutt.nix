{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.local.neomutt;
in
{
  options.local.neomutt = {
    enable = lib.mkEnableOption "neomutt";
    package = lib.mkPackageOption pkgs "neomutt" { };
    settings = lib.mkOption {
      type = with lib.types; nullOr lines;
      default = null;
    };
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      (lib.mkIf (cfg.settings == null) {
        environment.systemPackages = [ cfg.package ];
      })
      (lib.mkIf (cfg.settings != null) {
        local.wrap.wraps."neomutt" = {
          pkg = cfg.package;
          systemPackages = true;
          bins."neomutt".flags."-F".path = cfg.settings;
        };
      })
    ]
  );
}
