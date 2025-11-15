let
  sources = import ./sources.nix;
in
{
  nixpkgs ? sources.nixpkgs,

  sops-nix-module ? sources.sops-nix-module,
  disko-module ? sources.disko-module,
  getsuga-legion-module ? sources.getsuga-legion-module,

  nixpkgsHyprland ? sources.nixpkgsHyprland,

  lib ? import "${nixpkgs}/lib",
}:
lib.fix (self: {
  inherit nixpkgsHyprland;
  sourceModules = {
    sops-nix = sops-nix-module;
    disko = disko-module;
    getsuga-legion = getsuga-legion-module;
  };

  modules = import ./mods { inherit lib; };
  configs = import ./cfgs {
    inherit lib;
    inherit (self)
      modules
      configs
      sourceModules
      nixpkgsHyprland
      ;
  };

  nixosConfigurations =
    let
      eval-config = import "${nixpkgs}/nixos/lib/eval-config.nix";
    in
    builtins.mapAttrs (
      _: v:
      eval-config {
        # system = null lets us to set system with a { nixpkgs.system = ... } module
        # https://github.com/NixOS/nixpkgs/blob/bc820e509bacaf06dd07b5fc807d8756179df95b/nixos/lib/eval-config.nix#L12
        system = null;
        modules = [ v ];
      }
    ) self.configs;
})
