{ config, ... }:
{
  imports = [ ./local/mako.nix ];
  local.mako = {
    enable = true;
    settings =
      let
        inherit (config.local.themes."Everforest Dark Medium")
          fg
          bg
          ;
      in
      {
        background-color = fg.statusline1;
        text-color = bg.bg0;
        outer-margin = 5;
      };
  };
}
