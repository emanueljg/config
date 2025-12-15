{ pkgs, lib, ... }:
{
  imports = [ ../local/neomutt.nix ];

  local.neomutt = {
    enable = true;
    settings = ''
      set folder = imaps://imap.gmail.com/
      set imap_user = emanueljohnsongodin@gmail.com

      set realname = 'Emanuel Johnson Godin'
      set from = emanueljohnsongodin@gmail.com
      set ssl_force_tls
      set smtp_url=smtps://emanueljohnsongodin@smtp.gmail.com

      set account_command = "${lib.getExe (pkgs.callPackage ./neomutt-pass-acc { })}"
      set spoolfile   = +INBOX
      set imap_check_subscribed

      set sidebar_visible

    '';
  };
}
