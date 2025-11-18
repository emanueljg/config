{ pkgs, ... }:
{
  environment.systemPackages = [
    # nixpth
    # outputs the value of the given NIX_PATH variable
    (pkgs.writeShellApplication {
      name = "nixpth";
      text = ''
        nix-instantiate --eval --expr "<$1>"
      '';
    })
    # nixb
    # trivial builder for a callPackage-form package
    # first arg is path to package, rest is passed to nix-build
    (pkgs.writeShellApplication {
      name = "nixb";
      text = ''
        nix-build --expr "(import <nixpkgs> { }).callPackage ./$1 { }" "''${@:2}"
      '';
    })
  ];

  _file = ./nix-helpers.nix;
}
