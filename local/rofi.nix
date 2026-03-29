{
  custom,
  pkgs,
  lib,
  ...
}:
{
  imports = [ custom.rofi ];

  custom.programs.rofi = {
    enable = true;
    settings = {
      "@theme" = "${
        pkgs.fetchFromGitHub {
          owner = "dennis-n-schneider";
          repo = "rofi-everforest";
          rev = "main";
          hash = "sha256-c4z5Whm7E0SEP88IQZHxI57vTXjHksf+MtZrl9QMJsA=";
        }
      }/everforest.rasi";
    };
  };
}
