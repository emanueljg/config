{ lib, ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
  local.allowed-unfree.names = [
    "steam"
    "steam-unwrapped"
  ];
}
