{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.slack
  ];
  xdg.mime.defaultApplications = {
    "x-scheme-handler/slack" = [ "slack.desktop" ];
  };

  custom.allowed-unfree.names = [ "slack" ];
}
