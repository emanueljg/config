{ pkgs, lib, ... }:
{
  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "river";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "river";
  };
  environment.systemPackages = [
    pkgs.bemenu
    pkgs.wofi
    pkgs.slurp
  ];
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = lib.mkForce [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = [
      "wlr"
      "gtk"
    ];
    wlr = {
      enable = true;
      settings.screencast = {
        # output_name = "eDP-2";
        chooser_type = "simple";
        # chooser_cmd = "${lib.getExe pkgs.wofi} --show=${lib.getExe pkgs.dmenu}";
        chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
      };
    };
  };
}
