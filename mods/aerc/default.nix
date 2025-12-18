{
  config,
  pkgs,
  lib,
  ...
}:
{

  imports = [ ../local/aerc.nix ];

  sops.secrets."aerc-accounts" = {
    sopsFile = ./sops-accounts.ini;
    mode = "0400";
    owner = "ejg";
    group = "users";
    format = "ini";
  };

  local.aerc = {
    enable = true;
    aercSettings = {
      general = {
        term = "foot";
        default-menu-cmd = lib.getExe pkgs.fzf;
      };
    };
    accountsConfPath = config.sops.secrets."aerc-accounts".path;
  };

}
