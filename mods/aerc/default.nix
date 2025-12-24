{
  config,
  pkgs,
  lib,
  ...
}:
{

  imports = [
    ../local/aerc

    ./accounts.nix
    ./binds.nix
    ./hooks.nix
    ./ui.nix
  ];

  environment.systemPackages = [
    pkgs.chawan
  ];

  local.aerc = {
    enable = true;
    package = pkgs.aerc.overrideAttrs (prevAttrs: {
      # aerc: commands: add :toggle-sidebar command v1
      patches = (prevAttrs.patches or [ ]) ++ [
        (pkgs.fetchpatch {
          url = "https://lists.sr.ht/~rjarry/aerc-devel/patches/63771/mbox";
          hash = "sha256-TAqA5bBKHdHJZBRHT9FKMgYaeLQ+nU/lzDYiEYkFBXA=";
        })
      ];
    });
    folderMap = {
      "*" = "[Gmail]/*";
    };
    aercSettings = {
      general = {
        term = "foot";
        # term = lib.getExe config.programs.foot.package;
        default-menu-cmd = lib.getExe pkgs.fzf;
      };
      openers = {
        "x-scheme-handler/http*" = "printf '%s' {} | wl-copy";
        "text/plain" = "hx {}";
        "text/html" = "qutebrowser {}";
      };
      filters = {
        "text/plain" = "colorize";
        "text/html" = "! ${lib.getExe pkgs.chawan} -o buffer.images=false -T text/html";
      };
    };
  };

}
