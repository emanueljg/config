{ config, custom, ... }:
{
  imports = [ custom.mako ];
  custom.programs.mako = {
    enable = true;
    settings =
      let
        inherit (config.custom.themes."Everforest Dark Medium")
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
