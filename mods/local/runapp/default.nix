{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.local.runapp;
in
{
  options.local.runapp = {
    enable = lib.mkEnableOption "runapp";
    package = lib.mkPackageOption pkgs "runapp" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };

}
