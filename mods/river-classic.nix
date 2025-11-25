{ lib, pkgs, ... }:
{
  imports = [
    ./local/river-classic
  ];

  local.greetd.tuigreet.cmd = "river-start";

  local.river-classic = {
    enable = true;
    init = {
      text = ''
        riverctl keyboard-layout \
          -variant 'altgr-intl' \
        	-options 'caps:swapescape' \
          us
        riverctl map normal Alt Backspace spawn qutebrowser
      '';
    };
  };
}
