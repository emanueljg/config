{
  pkgs,
  lib,
  config,
  ...
}:
{
  environment.systemPackages = lib.mapAttrsToList (
    _: v:
    pkgs.writeShellApplication {
      name = "git-init-${v.classifier}-${config.networking.hostName}";
      runtimeInputs = [ config.programs.git.package ];
      text = ''
        git config user.email '${v.email}'
        git config user.name '${v.username}'

        git config user.signingKey '${v.subKeys.${config.networking.hostName}.sign}'
      '';
    }
  ) config.custom.gpg-keys.masterKeys;
}
