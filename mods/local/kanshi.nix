{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.local.kanshi;

  outputOption = lib.mkOption {
    default = { };
    type =
      with lib.types;
      attrsOf (
        listOf (oneOf [
          str
          int
        ])
      );
  };

  profileType = lib.types.submodule (
    { name, ... }:
    {
      options = {
        name = lib.mkOption {
          type = lib.types.str;
          default = name;
        };
        output = outputOption;
        exec = lib.mkOption {
          type = with lib.types; listOf str;
          default = [ ];
        };
      };
    }
  );

  mkOutputDirectives =
    sep: outputAttrs:
    lib.concatMapAttrsStringSep sep (
      output: directives:
      ''output "${output}" ${
        lib.concatMapStringsSep " " (directive: ''"${builtins.toString directive}"'') directives
      }''
    ) outputAttrs;

in
{
  options.local.kanshi = {
    enable = lib.mkEnableOption "kanshi";
    package = lib.mkPackageOption pkgs "kanshi" { };

    output = outputOption;

    profile = lib.mkOption {
      default = { };
      type = lib.types.attrsOf profileType;
    };
  };

  config = lib.mkIf cfg.enable {

    local.wrap.wraps."kanshi" = {
      pkg = cfg.package;
      systemPackages = true;
      bins."kanshi".flags = {
        "--config".path = ''
          ${mkOutputDirectives "\n" cfg.output}

          ${lib.concatMapAttrsStringSep "\n" (profile: directives: ''
            profile "${profile}" {
              ${mkOutputDirectives "\n  " directives.output} 
              ${lib.concatMapStringsSep "\n  " (exec: "exec ${exec}") directives.exec} 
            } 
          '') cfg.profile}
        '';
      };
    };

    systemd.user.services."kanshi" = {
      description = "Dynamic output configuration for Wayland compositors";
      documentation = [ "https://gitlab.freedesktop.org/emersion/kanshi" ];

      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      requisite = [ "graphical-session.target" ];

      serviceConfig = {
        ExecStart = "${lib.getExe config.local.wrap.wraps."kanshi".finalPackage}";
        ExecReload = "kill -SIGHUP $MAINPID";
        Restart = "on-failure";
      };
    };
  };
}
