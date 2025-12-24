{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.local.fzf-preview;
in
{
  options.local.fzf-preview = {
    enable = lib.mkEnableOption "fzf-preview";
    package = lib.mkOption {
      default = pkgs.callPackage ./package.nix { };
      type = lib.types.package;
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  };
}
