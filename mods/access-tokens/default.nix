{
  self,
  lib,
  config,
  ...
}:
let
  accessTokens = [
    "base"
    "vidya"
  ];

in
lib.mkMerge (
  map (accessToken: {
    sops = {
      secrets.${accessToken} = {
        mode = "0440";
        sopsFile = ./sops.yml;
      };
    };

    nix.extraOptions = ''
      !include ${config.sops.secrets.${accessToken}.path}
    '';

  }) accessTokens
)
