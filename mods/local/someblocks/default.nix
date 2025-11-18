{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.local.programs.someblocks;
in
{
  options.local.programs.someblocks = {
    enable = lib.mkEnableOption "someblocks";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.callPackage ./package.nix { };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
