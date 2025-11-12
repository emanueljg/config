{ self, config, ... }:
{
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  sops.secrets =
    let
      owner = "ejg";
      group = "users";
      mode = "0400";
      sopsFile = "${self}/secrets/${config.networking.hostName}/oci.yml";
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
