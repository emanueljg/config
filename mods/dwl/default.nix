{
  pkgs,
  config,
  lib,
  ...
}:
{
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "run-bar" ''
      someblocks &
      somebar
    '')
  ];
  local.greetd.tuigreet.cmd = "dwl -s run-bar";

  programs.dwl = {
    enable = true;
    package = (
      pkgs.dwl.overrideAttrs (prev: {
        patches = (prev.patches or [ ]) ++ [
          (pkgs.fetchpatch {
            url = "https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/monitorconfig/monitorconfig.patch";
            hash = "sha256-BVgbQkIr9m3OLZxcghYAnOK15TJTS/C/ozgX74Shm/A=";
          })
        ];
        postPatch =
          let
            theme = config.local.themes."Everforest Dark Medium";
            focus = lib.removePrefix "#" theme.fg.statusline1;
          in
          (prev.postPatch or "")
          + ''
            cp ${./config.def.h} config.h
            substituteInPlace 'config.h' \
              --replace-fail \
                'static const float focuscolor[]            = COLOR(0x005577ff);' \
                'static const float focuscolor[]            = COLOR(0x${focus}ff);'
                
          '';
      })
    );
  };
}
