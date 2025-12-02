{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.local.kanshi;

  outputs = lib.mkOption {
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
        inherit outputs;
        # I don't use this
        # exec = lib.mkOption {
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

    inherit outputs;

    profiles = lib.mkOption {
      default = { };
      type = lib.types.attrsOf profileType;
    };
  };

  config = lib.mkIf cfg.enable {

    local.wrap.wraps."kanshi" = {
      pkg = cfg.package;
      systemPackages = true;
      bins."kanshi".flags."--config".path = ''
        ${mkOutputDirectives "\n" cfg.outputs}

        ${lib.concatMapAttrsStringSep "\n" (profile: directives: ''
          profile "${profile}" {
            ${mkOutputDirectives "\n  " directives.outputs} 
          } 
        '') cfg.profiles}
      '';
    };
  };
}
