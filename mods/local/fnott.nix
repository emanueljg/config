{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.local.fnott;
in
{
  options.local.fnott = {
    enable = lib.mkEnableOption "fnott";
    package = lib.mkPackageOption pkgs "mako" { };
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
