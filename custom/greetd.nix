{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.custom.services.greetd;
in
{
  _file = ./greetd.nix;
  options.custom.services.greetd = {
    enable = lib.mkEnableOption "greet";

    tuigreet = {
      cmd = lib.mkOption {
        type = with lib.types; nullOr str;
        default = null;
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
      lib.cli.toCommandLineShellGNU { } (cfg.tuigreet.extraOptions // { inherit (cfg.tuigreet) cmd; })
    }";
  };
}
