{ config, ... }:
{

  sops.secrets."aerc-accounts" = {
    sopsFile = ./sops-accounts.ini;
    mode = "0400";
    owner = "ejg";
    group = "users";
    format = "ini";
  };

  local.aerc.accountsConfPath = config.sops.secrets."aerc-accounts".path;
}
