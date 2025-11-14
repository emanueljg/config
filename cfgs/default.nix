{
  lib,
  self,
  nixpkgs,
  nixpkgsHyprland,
}:
lib.mapAttrs' (
  n: v:
  lib.nameValuePair (lib.removeSuffix ".nix" n) (
    import (./. + "/${n}") {
      inherit lib nixpkgs nixpkgsHyprland;
      inherit (self) modules sourceModules configs;
    }
  )
) (builtins.removeAttrs (builtins.readDir ./.) [ "default.nix" ])
