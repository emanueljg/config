{
  pkgs,
  ...
}:
{
  _file = ./greetd.nix;
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
