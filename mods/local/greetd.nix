{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.local.greetd;
in
{
  _file = ./greetd.nix;
  options.local.greetd = {
    enable = lib.mkEnableOption "greet";

    tuigreet = {
      cmd = lib.mkOption {
        type = lib.types.str;
      };
      extraOptions = lib.mkOption {
        type = with lib.types; attrsOf anything;
        default = { };
      };
    };
  };
  config.services.greetd = lib.mkIf cfg.enable {
    enable = true;
    useTextGreeter = true;
    settings.default_session.command = "${lib.getExe pkgs.tuigreet} ${
      lib.cli.toGNUCommandLineShell { } (cfg.tuigreet.extraOptions // { inherit (cfg.tuigreet) cmd; })
    }";
  };
}
