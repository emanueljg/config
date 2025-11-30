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
      postWrap = ''
        mv $out/lib/systemd/user/waybar.service \
           $out/lib/systemd/user/waybar.service.upstream
        substitute $out/lib/systemd/user/waybar.service.upstream \
                   $out/lib/systemd/user/waybar.service \
          --replace-fail 'ExecStart=${lib.getExe cfg.package}' \
                         "ExecStart=$out/bin/waybar"
        rm $out/lib/systemd/user/waybar.service.upstream
      '';
    };

    systemd.packages = [ config.local.wrap.wraps."waybar".finalPackage ];
  };
}
