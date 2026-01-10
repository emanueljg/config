{
  sources ? import ./sources.nix,

  nixpkgs ? sources.nixpkgs,
  lib ? import "${nixpkgs}/lib",

  sops-nix-module ? sources.sops-nix-module,
  disko-module ? sources.disko-module,
  getsuga-legion-module ? sources.getsuga-legion-module,
}:
{
  inherit nixpkgs;

  cfg =
    let
      eval-config = import "${nixpkgs}/nixos/lib/eval-config.nix";
      importer = import ./importer.nix { inherit lib; };
      cfg = importer { root = ./cfg; };
    in
    builtins.mapAttrs (
      _: v:
      eval-config {
        # system = null lets us to set system with a { nixpkgs.system = ... } module
        # https://github.com/NixOS/nixpkgs/blob/bc820e509bacaf06dd07b5fc807d8756179df95b/nixos/lib/eval-config.nix#L12
        system = null;
        modules = [ v ];
        specialArgs = {

          inherit cfg;
          partial = importer { root = ./partial; };
          custom = importer { root = ./custom; };
          local = importer { root = ./local; };

          remote = {
            sops-nix = sops-nix-module;
            disko = disko-module;
            getsuga-legion = getsuga-legion-module;
          };

        };
      }
    ) cfg;
}
