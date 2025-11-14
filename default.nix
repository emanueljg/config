let
  sources = import ./sources.nix;
in
{
  nixpkgs ? sources.nixpkgs,
  sops-nix-module ? sources.sops-nix-module,
  disko-module ? sources.disko-module,
  getsuga-legion-module ? sources.getsuga-legion-module,

  nixpkgsHyprland ? sources.nixpkgsHyprland,
}:
let
  lib = import "${nixpkgs}/lib";
  eval-config = import "${nixpkgs}/nixos/lib/eval-config.nix";
in
lib.fix (self: {
  sourceModules = {
    sops-nix = sops-nix-module;
    disko = disko-module;
    getsuga-legion = getsuga-legion-module;
  };

  modules = import ./mods { inherit lib; };
  configs = import ./cfgs {
    inherit
      lib
      nixpkgs
      self
      nixpkgsHyprland
      ;
  };

  nixosConfigurations =
    builtins.removeAttrs
      (builtins.mapAttrs (
        _: v:
        eval-config {
          # the following allows us to set system with a { nixpkgs.system = ... } module
          # https://github.com/NixOS/nixpkgs/blob/bc820e509bacaf06dd07b5fc807d8756179df95b/nixos/lib/eval-config.nix#L12
          system = null;
          modules = [ v ];
        }
      ) self.configs)
      [
        "base"
        "pc"
      ];
})
