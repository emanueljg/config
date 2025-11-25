{
  lib,
  config,
  ...
}:
{
  imports = [
    ../local/river-classic
  ];

  local.greetd.tuigreet.cmd = "river-start";

  local.river-classic = {
    enable = true;
    init.text = lib.mkForce (
      builtins.foldl' (
        acc: elem:
        if lib.hasSuffix ".sh" elem then
          ''
            ${acc}
            ${builtins.readFile (./. + "/${elem}")}
          ''
        else
          acc
      ) "set -x" (builtins.attrNames (builtins.readDir ./.))
    );
  };
}
