{ custom, ... }:
{

  imports = [ custom.allowed-unfree ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
  custom.allowed-unfree.names = [
    "steam"
    "steam-unwrapped"
  ];
}
