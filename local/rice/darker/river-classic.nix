{ config, lib, ... }:
let
  theme = config.custom.themes."Everforest Dark Medium";
in
{
  custom.programs.river-classic.init.text = lib.mkForce ''
    riverctl border-width 5
    riverctl background-color 0x002b36
    riverctl border-color-focused 0x${lib.removePrefix "#" theme.fg.statusline1}
    riverctl border-color-unfocused 0x586e75
  '';
}
