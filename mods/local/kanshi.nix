{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.local.kanshi;
in
{
  options.local.kanshi = {
    enable = lib.mkEnableOption "kanshi";
    package = lib.mkPackageOption pkgs "kanshi" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

  };
}
