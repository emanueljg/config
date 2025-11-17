{ pkgs, lib, ... }:
{
  _file = ./greetd.nix;
  services.xserver.displayManager.startx = {
    enable = true;
    generateScript = false;
  };
  local.greetd = {
    enable = true;
    tuigreet.extraOptions = {
      time = true;
      remember = true;
      remember-user-session = true;
      asterisks = true;
      user-menu = true;
    };
  };
}
