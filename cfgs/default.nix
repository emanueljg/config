{
  lib,
  ...
}@args:
lib.mapAttrs' (n: v: lib.nameValuePair (lib.removeSuffix ".nix" n) (import (./. + "/${n}") args)) (
  builtins.removeAttrs (builtins.readDir ./.) [ "default.nix" ]
)
