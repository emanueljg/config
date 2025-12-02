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
    package = lib.mkOption {
      type = lib.types.package;
      # https://github.com/NixOS/nixpkgs/pull/447721
      default = pkgs.callPackage ./package.nix { };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };

}
