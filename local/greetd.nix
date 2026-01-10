{ custom, ... }:
{
  imports = [ custom.greetd ];

  custom.services.greetd = {
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
