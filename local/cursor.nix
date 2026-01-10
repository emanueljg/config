{ pkgs, custom, ... }:
{
  imports = [ custom.cursor ];
  custom.cursor = {
    enable = true;
    package = pkgs.borealis-cursors;
    name = "Borealis-cursors";
    gtk.enable = true;
    hyprcursor.enable = true;
  };
}
