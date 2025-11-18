{
  pkgs,
  config,
  lib,
  ...
}:
{
  services.wlock = {
    enable = true;
    package = pkgs.wlock.overrideAttrs (prev: {
      src = pkgs.fetchFromGitea {
        domain = "codeberg.org";
        owner = "sewn";
        repo = "wlock";
        rev = "master";
        hash = "sha256-RG5D8q6fOWzphkyOFHFRzAjZwSVLwAZtecQOryIawAc=";
        # hash = "sha256-vbGrePrZN+IWwzwoNUzMHmb6k9nQbRLVZmbWIAsYneY=";
      };

      patches = (prev.patches or [ ]) ++ [

        # https://codeberg.org/sewn/wlock/issues/34
        # this is an unbelievable patch
        # I cannot believe that I had to write it myself
        # I barely barely barely know C
        # I literally had to sit down and learn how
        # bit operations work, but I suppose on the upside,
        # it now just works
        ./fix-shitty-wlock-color-type.patch
      ];

      postPatch =
        let
          theme = config.local.themes."Everforest Dark Medium";
          init = theme.bg.bg_dim;
          input = theme.bg.bg0;
          inputAlt = input;
          fail = theme.bg.bg_red;

          f = color: lib.removePrefix "#" color;
        in
        (prev.postPatch or "")
        + ''
          substituteInPlace config.def.h \
            --replace-fail \
              '[INIT]      = 0x000000, /* after initialization */' \
              '[INIT]      = 0x${f init}, /* after initialization */' \
            --replace-fail \
              '[INPUT]     = 0x005577, /* during input */' \
              '[INPUT]     = 0x${f input}, /* during input */' \
            --replace-fail \
              '[INPUT_ALT] = 0x005070, /* during input, second color */' \
              '[INPUT_ALT] = 0x${f inputAlt}, /* during input, second color */' \
            --replace-fail \
              '[FAILED]    = 0xcc3333, /* wrong password */' \
              '[FAILED]    = 0x${f fail}, /* wrong password */'
        '';
    });
  };
}
