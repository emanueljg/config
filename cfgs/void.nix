{
  inputs,
  modules,
  configs,
  lib,
  ...
}:
cfg:
let
  parent = configs.base;
in
{

  system = "x86_64-linux";

  inherit (parent) specialArgs;

  modules =
    parent.modules
    ++ (with modules; [
      hostnames.void
      lan.void
      hw.nvidia
      hw.void

      sonarr
      # fuck this shit
      # invidious
      jellyfin
      navidrome
      rutorrent
      rtorrent

      nginx
      porkbun

      nixos-rebuild.void

      stateversions."22-11"

    ]);
}
