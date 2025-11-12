{
  config,
  lib,
  pkgs,
  self,
  terraform,
  ...
}:
{
  # allow ejg to remote build
  nix.settings.trusted-users = [ "ejg" ];

  # boot.loader.systemd-boot.enable = true;
  # boot.loader.grub.enable = lib.mkForce false;
  boot.loader.grub = {
    enable = true;
    device = lib.mkForce "/dev/sda";
    efiSupport = true;
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "nvme"
    "thunderbolt"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];

  boot.supportedFilesystems = [
    "btrfs"
    "ext2"
    "ext3"
    "ext4"
    "exfat"
    "f2fs"
    "fat8"
    "fat16"
    "fat32"
    "ntfs"
    "xfs"
  ];

  networking.interfaces.enp0s6.useDHCP = true;
  # networking.interfaces.enp0s6.ipv4.addresses = [
  #   {
  #     address = terraform.ip;
  #     prefixLength = 24;
  #   }
  # ];

  # networking.defaultGateway = {
  #   address = "10.0.0.1";
  #   interface = "enp0s6";
  #   source = terraform.ip;
  # };

  # required now
  networking.firewall.allowedTCPPorts = [ 22 ];

  # networking.interfaces.eth0.ipv4.addresses = [
  #   {
  #     address = terraform.ip; # Use the IP from nixos-vars.json
  #     prefixLength = 24;
  #   }
  # ];

  # service
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "yes";

    };

  };

  users.users =
    let
      users = [
        "ejg"
        "root"
      ];
    in
    lib.genAttrs users (_: {
      openssh.authorizedKeys.keyFiles = [
        "${self}/terraform/oracle-terraform-ssh.pub"
      ];
    });
}
