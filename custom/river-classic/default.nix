{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.custom.programs.river-classic;
in
{
  options.custom.programs.river-classic = {
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

    addToUWSM = lib.mkEnableOption "river-classic UWSM support";

  };

  config = lib.mkIf cfg.enable {
    custom.programs.river-classic.init.text = ''
      systemctl --user import-environment DISPLAY WAYLAND_DISPLAY
      ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd "DISPLAY" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP" "NIXOS_OZONE_WL" "XCURSOR_THEME" "XCURSOR_SIZE"
      systemctl --user restart river-session

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

    programs.uwsm.waylandCompositors."river-classic" = lib.mkIf cfg.addToUWSM {
      prettyName = "river-classic";
      comment = "custom.programs uwsm";
      binPath = "/run/current-system/sw/bin/river-start";
    };

    systemd.user.targets.river-session = {
      description = "river compositor session";
      documentation = [ "man:systemd.special(7)" ];
      bindsTo = [ "graphical-session.target" ];
      wants = [ "graphical-session-pre.target" ];
      after = [ "graphical-session-pre.target" ];
    };
  };

}
