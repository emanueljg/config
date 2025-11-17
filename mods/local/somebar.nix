{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.local.programs.somebar;
in
{
  _file = ./somebar.nix;
  options.local.programs.somebar = {
    enable = lib.mkEnableOption "somebar";
    package = lib.mkPackageOption pkgs "somebar" { };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
