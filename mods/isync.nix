{
  lib,
  pkgs,
  config,
  ...
}:
{
  imports = [ ./local/isync.nix ];

  local.isync = {
    enable = false;
    settings = {
      IMAPAccount.ejg = {
        Host = "imap.gmail.com";
        Port = 993;
        User = "emanueljohnsongodin@gmail.com";
      };
      IMAPAccount.work = {
        Host = "smtp.gmail.com";
      };
    };
  };
}
