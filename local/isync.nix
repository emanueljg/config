{
  custom,
  ...
}:
{
  imports = [ custom.isync ];

  custom.programs.isync = {
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
