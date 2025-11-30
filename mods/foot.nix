{ config, lib, ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font Mono:size=18";
      };
      colors =
        let
          inherit (config.local.themes."Everforest Dark Medium")
            fg
            bg
            ;
          f = color: lib.removePrefix "#" color;
        in
        {
          foreground = f fg.fg;
          background = f bg.bg0;
          selection-foreground = f fg.grey2;
          selection-background = "505a60";

          cursor = "${f bg.bg1} ${f fg.fg}";

          urls = f fg.blue;

          #: black
          regular0 = "343f44";
          bright0 = " 868d80";

          #: red
          regular1 = "e67e80";
          bright1 = " e67e80";

          #: green
          regular2 = "a7c080";
          bright2 = "a7c080";

          #: yellow
          regular3 = "dbbc7f";
          bright3 = "dbbc7f";

          #: blue
          regular4 = "7fbbb3";
          bright4 = "7fbbb3";

          #: magenta
          regular5 = "d699b6";
          bright5 = "d699b6";

          #: cyan
          regular6 = "83c092";
          bright6 = "83c092";

          #: white
          regular7 = "859289";
          bright7 = "9da9a0";

        };
    };
  };
}
