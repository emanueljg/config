{
  pkgs,
  config,
  lib,
  ...
}:
{
  _file = ./somebar.nix;
  imports = [ ../local/somebar.nix ];
  local.programs.somebar = {
    enable = true;
    package =
      (pkgs.somebar.overrideAttrs (prev: {
        src = pkgs.fetchFromSourcehut {
          owner = "~raphi";
          repo = "somebar";
          rev = "master";
          hash = "sha256-4s9tj5+lOkYjF5cuFRrR1R1S5nzqvZFq9SUAFuA8QXc=";
        };
        patches = (prev.patches or [ ]) ++ [
          ./colorless-layout-and-title.patch

          # (pkgs.fetchpatch {
          #   url = "https://git.sr.ht/~raphi/somebar/blob/master/contrib/colorless-status.patch";
          #   hash = "sha256-MSReljoSB0wS1gPumrGNz15UVyP/p9geshbrr+dY2Pw=";
          # })
        ];
      })).override
        {
          conf =
            let
              theme = config.local.themes."Everforest Dark Medium";
              toRGBBytes =
                s: "0x${builtins.substring 1 2 s}, 0x${builtins.substring 3 2 s}, 0x${builtins.substring 5 2 s}";
            in
            pkgs.replaceVars ./config.def.hpp (
              lib.fix (self: {
                COLOR_INACTIVE_FG = toRGBBytes theme.fg.fg;
                COLOR_INACTIVE_BG = toRGBBytes theme.bg.bg0;

                COLOR_ACTIVE_FG = self.COLOR_INACTIVE_BG;
                COLOR_ACTIVE_BG = toRGBBytes theme.fg.statusline1;
              })
            );
        };
  };
}
