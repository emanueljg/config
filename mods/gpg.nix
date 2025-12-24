{ pkgs, ... }:
{
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
  };

  environment.variables."GNUPGHOME" = "/run/media/ejg/Ventoy/gnupg";
}
