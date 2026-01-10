{ pkgs, ... }:
{
  nix.nixPath = [
    # NOTE: this'll be nixos-unstable
    "nixpkgs=${pkgs.path}"
  ];

  _file = ./nixpkgs-var.nix;
}
