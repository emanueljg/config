{
  lib,
  self,
  nixpkgs,
}:
lib.mapAttrs' (
  n: v:
  lib.nameValuePair (lib.removeSuffix ".nix" n) (
    import (./. + "/${n}") {
      inherit lib nixpkgs;
      inherit (self) modules sourceModules configs;
    }
  )
) (builtins.removeAttrs (builtins.readDir ./.) [ "default.nix" ])
