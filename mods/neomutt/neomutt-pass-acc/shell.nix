let
  pkgs = import (import ./sources.nix).nixpkgs { };
in
pkgs.mkShell {
  packages = [
    pkgs.rustc
    pkgs.cargo
    pkgs.gpgme.dev
    pkgs.pkg-config
  ];
}
