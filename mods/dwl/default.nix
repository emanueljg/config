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
        src = pkgs.fetchFromGitea {
          domain = "codeberg.org";
          owner = "dwl";
          repo = "dwl";
          rev = "main";
          hash = "sha256-ihxF9Z4uT0K3omO4mbzkeICY/RyqvuD+C5JSGWIf6MI=";
        };
        patches = (prev.patches or [ ]) ++ [
          # (pkgs.fetchpatch {
          #   url = "https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/unclutter/unclutter.patch";
          #   hash = "sha256-4i4QLJVOrGkKd3HhNykrKwV/cftlo5ctcDdo4J7IOHI=";
          # })
          # (pkgs.fetchpatch {
          #   url = "https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/warpcursor/warpcursor.patch";
          #   hash = "sha256-0AGMq507WmW2QJW02u6eJDuQmGBAiVPbEw79npwqEDU=";
          # })
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
