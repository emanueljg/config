{
  lib,
  ...
}:
{
  imports = [
    ../local/river-classic
  ];

  local.river-classic = {
    enable = true;
    addToUWSM = true;
    init.text = lib.mkForce (
      builtins.foldl'
        (
          acc: elem:
          if lib.hasSuffix ".sh" elem then
            ''
              ${acc}
              ${builtins.readFile (./. + "/${elem}")}
            ''
          else
            acc
        )
        ''
          set -x
          systemctl --user import-environment DISPLAY WAYLAND_DISPLAY
        ''
        (builtins.attrNames (builtins.readDir ./.))
    );
  };
}
