{
  lib,
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./local/river-classic
  ];

  local.greetd.tuigreet.cmd = "river-start";

  local.river-classic = {
    enable = true;
    init = {
      text =
        let
          theme = config.local.themes."Everforest Dark Medium";
        in
        ''
          riverctl keyboard-layout \
            -variant 'altgr-intl' \
          	-options 'caps:swapescape' \
            us

          riverctl map normal Alt Backspace spawn qutebrowser

          riverctl set-cursor-warp on-focus-change
          riverctl hide-cursor when-typing enabled

          riverctl border-width 5
          riverctl border-color-focused 0x${lib.removePrefix "#" theme.fg.statusline1}

          riverctl send-layout-cmd rivertile "main-ratio 0.55"
        '';
    };
  };
}
