let
  sources = import ./sources.nix;
in
{
  nixpkgs ? sources.nixpkgs,
  sops-nix-module ? sources.sops-nix-module,
  disko-module ? sources.disko-module,
  getsuga-legion-module ? sources.getsuga-legion-module,
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

  modules =
    let
      modulesToAttrs =
        cursor:
        let
          paths = builtins.readDir cursor;
        in
        if paths ? "default.nix" then
          (import cursor)
        else
          (lib.filterAttrsRecursive (_: v: v != null) (
            lib.mapAttrs' (
              n: v:
              lib.nameValuePair (if v == "regular" then (lib.removeSuffix ".nix" n) else n) (
                if v == "regular" && !(lib.hasSuffix ".nix" n) then
                  null
                else if v == "regular" then
                  (import "${cursor}/${n}")
                else if v == "directory" then
                  (modulesToAttrs "${cursor}/${n}")
                else
                  (builtins.throw "")
              )
            ) paths
          ));
    in
    modulesToAttrs ./mods;

  configs =
    let
      cfgDir = ./cfgs;
    in
    lib.mapAttrs' (
      n: v:
      lib.nameValuePair (lib.removeSuffix ".nix" n) (
        let
          x = (
            (import "${cfgDir}/${n}") {
              inherit lib nixpkgs;
              inherit (self) modules sourceModules configs;
            }
          );
        in
        if builtins.isFunction x then lib.fix x else x
      )
    ) (builtins.readDir cfgDir);

  nixosConfigurations = builtins.removeAttrs (builtins.mapAttrs (_: v: eval-config v) self.configs) [
    "base"
    "pc"
  ];
})
