{ lib }:
let
  modulesToAttrs =
    {
      cursor,
      paths ? builtins.readDir cursor,
    }:
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
              (modulesToAttrs { cursor = "${cursor}/${n}"; })
            else
              (builtins.throw "")
          )
        ) paths
      ));
in
modulesToAttrs {
  cursor = ./.;
  paths = builtins.removeAttrs (builtins.readDir ./.) [ "default.nix" ];
}
