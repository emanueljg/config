{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ../local/river-classic
  ];

  local.river-classic = {
    enable = true;
    package = pkgs.river-classic.overrideAttrs (prev: {
      patches = (prev.patches or [ ]) ++ [
        # qutebrowser and kitty (before I migrated to foot)
        # triggers this error
        # on literally every single keypres as of 2025-12-02,
        # which spams logs like crazy.
        # this removes that error.
        ./quiet-down-textarea-error.patch
      ];
    });
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
          systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP          
        ''
        (builtins.attrNames (builtins.readDir ./.))
    );
  };
}
