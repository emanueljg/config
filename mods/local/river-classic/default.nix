{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.local.river-classic;
in
{
  options.local.river-classic = {
    enable = lib.mkEnableOption "river-classic";
    package = lib.mkPackageOption pkgs "river-classic" { };

    init = {
      runtimeInputs = lib.mkOption {
        default = [ cfg.package ];
        type = with lib.types; listOf package;
      };
      text = lib.mkOption {
        type = lib.types.lines;
      };
      _drv = lib.mkOption {
        readOnly = true;
        type = lib.types.package;
        default = pkgs.writeShellApplication {
          name = "river-cfg";
          inherit (cfg.init) runtimeInputs text;
        };
      };
    };

  };

  config = lib.mkIf cfg.enable {
    local.river-classic.init.text = ''
      systemctl --user import-environment DISPLAY WAYLAND_DISPLAY
      ${builtins.readFile ./init.sh}
    '';

    programs.river-classic = {
      inherit (cfg) enable package;
    };

    environment.systemPackages = [
      cfg.init._drv
      (pkgs.writeShellApplication {
        name = "river-start";
        runtimeInputs = [ cfg.package ];
        text = ''
          river -c 'exec ${lib.getExe cfg.init._drv}'
        '';
      })
    ];

  };
}
