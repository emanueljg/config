{
  config,
  pkgs,
  lib,
  ...
}:
let
  settingsFormat = pkgs.formats.toml { };
  cfg = config.custom.programs.helix;
in
{
  options.custom.programs.helix = {
    enable = lib.mkEnableOption "helix";
    package = lib.mkPackageOption pkgs "helix" { };
    settings = lib.mkOption {
      inherit (settingsFormat) type;
      default = { };
    };
    languages = lib.mkOption {
      inherit (settingsFormat) type;
      default = { };
    };
  };

  config = lib.mkIf cfg.enable {
    environment.sessionVariables =
      let
        EDITOR = "hx";
      in
      {
        inherit EDITOR;
        SUDO_EDITOR = EDITOR;
        VISUAL = EDITOR;
      };
    custom.wrap.wraps."hx" = {
      pkg = pkgs.helix;
      systemPackages = true;
      bins."hx".envs."XDG_CONFIG_HOME".paths =
        let
          tomlFormat = pkgs.formats.toml { };
        in
        {
          "helix/config.toml" = tomlFormat.generate "helix-config.toml" cfg.settings;
          "helix/languages.toml" = tomlFormat.generate "helix-languages.toml" cfg.languages;
        };
    };
  };
}
