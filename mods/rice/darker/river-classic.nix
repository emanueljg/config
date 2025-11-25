{ config, lib, ... }:
let
  theme = config.local.themes."Everforest Dark Medium";
in
{
  local.river-classic.init.text = ''
    riverctl border-width 5
    riverctl background-color 0x002b36
    riverctl border-color-focused 0x${lib.removePrefix "#" theme.fg.statusline1}
    riverctl border-color-unfocused 0x586e75
  '';
}
