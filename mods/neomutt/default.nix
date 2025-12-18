{
  config,
  pkgs,
  lib,
  ...
}:
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

      bind pager j next-line 
      bind pager k previous-line 

      bind index,pager \Cj sidebar-next
      bind index,pager \Ck sidebar-prev
      bind index,pager \Cl sidebar-open

      macro index,pager d <copy-message><kill-line>+[Gmail]/Papperskorgen<Enter>y

      mailboxes -notify -poll -label ibx +INBOX

      mailboxes -nonotify -nopoll +[Gmail]/Papperskorgen
      mailboxes -nonotify -nopoll +[Gmail]/Skräppost

      mailboxes -nonotify -nopoll -label 'af-dec-2025' '+AF dec 2025'
      mailboxes -nonotify -nopoll -label kvitton +Kvitton
      mailboxes -nonotify -nopoll -label nordomatic +Nordomatic
      mailboxes -nonotify -nopoll -label hemligheter +hemligheter
      mailboxes -nonotify -nopoll -label misc +misc
      mailboxes -nonotify -nopoll -label nostalgibilder +nostalgibilder

      set new_mail_command = "${
        lib.getExe (
          pkgs.writeShellApplication {
            name = "neomutt-notification-script";
            runtimeInputs = [
              pkgs.libnotify
            ];
            text = ''
              notify-send \
                --app-name=neomutt \
                --icon='${config.local.neomutt.package}/share/neomutt/logo/neomutt-256.png' \
                'new email received' \
                '%n new messages, %u unread.' \
                
            '';
          }
        )
      } &"

    '';
  };
}
