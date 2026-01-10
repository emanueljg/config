{ custom, pkgs, ... }:
{
  imports = [ custom.gtk ];

  custom.gtk = {
    enable = true;
    theme = {
      package = pkgs.everforest-gtk-theme;
      name = "Everforest-Dark-BL-LB";
    };
  };
}
