{ pkgs, lib, ... }:
{
  local.aerc.aercSettings.hooks = {
    mail-received = lib.concatStringsSep " " [
      (lib.getExe' pkgs.libnotify "notify-send")
      (lib.cli.toGNUCommandLineShell { } {
        app-name = "aerc";
        icon = pkgs.fetchurl {
          url = "https://git.sr.ht/~rjarry/aerc/blob/master/contrib/logo.svg";
          hash = "sha256-gNRoJiZ5dW8mNjhtinMIBi7qb59mrZJj1yFeq2XQ58o=";
        };
      })
      ''"[$AERC_ACCOUNT/$AERC_FOLDER] <$AERC_FROM_NAME>"''
      ''"AERC_SUBJECT"''
    ];
  };
}
