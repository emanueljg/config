{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.local.programs.waybar;
in
{
  options.local.programs.waybar = with lib.types; {
    enable = lib.mkEnableOption "Waybar";

    package = lib.mkPackageOption pkgs "waybar" { };
    style = lib.mkOption {
      type = with lib.types; nullOr (either path lines);
      default = null;
    };

    settings = lib.mkOption {
      default = { };
      type = with lib.types; attrsOf anything;
    };
  };

  config = lib.mkIf cfg.enable {
    local.wrap.wraps."waybar" = {
      pkg = cfg.package;
      systemPackages = true;
      bins."waybar".envs."XDG_CONFIG_HOME".paths = {
        "waybar/config" = builtins.toJSON (builtins.attrValues cfg.settings);
        "waybar/style.css" = cfg.style;
      };
    };
    # https://github.com/NixOS/nixpkgs/pull/340874/commits/a03d5e6f56fc83152d17a05226d230f143942da5
    # forces a .wants symlink
    systemd.user.services.waybar.wantedBy = [ "graphical-session.target" ];

    systemd.packages = [ config.local.wrap.wraps."waybar".finalPackage ];
  };
}
