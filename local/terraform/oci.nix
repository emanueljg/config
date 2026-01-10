{ self, config, ... }:
{
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  sops.secrets =
    let
      owner = "ejg";
      group = "users";
      mode = "0400";
      sopsFile = ./sops.yml;
    in
    {
      "oci-rsa-private.pem" = {
        inherit
          owner
          group
          mode
          sopsFile
          ;
      };
      "terraform-oracle-ssh" = {
        inherit
          owner
          group
          mode
          sopsFile
          ;
      };
    };
}
