locals {
    hostname = "cavendish"
}

resource "oci_core_instance" "ubuntu_instance" {
    # Required
    availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
    compartment_id = oci_identity_compartment.tf-compartment.id
    shape = "VM.Standard.A1.Flex"
    shape_config {
        ocpus = "4"
        memory_in_gbs = "24"
    }
    source_details {
        boot_volume_size_in_gbs = "200"
        source_id = "ocid1.image.oc1.eu-stockholm-1.aaaaaaaayjmlhokg7pot57oohemqex267vdz6hsskpbbxn45uevynocq7btq"
        source_type = "image"
    }

    # Optional
    display_name = local.hostname
    create_vnic_details {
        assign_public_ip = true
        subnet_id = oci_core_subnet.vcn-public-subnet.id
    }

    metadata = {
        ssh_authorized_keys = file("./oracle-terraform-ssh.pub")
    } 
    preserve_boot_volume = false
}

# module "deploy" {
#   source                 = "github.com/nix-community/nixos-anywhere//terraform/all-in-one"
#   # with flakes
#   nixos_system_attr      = ".#nixosConfigurations.${local.hostname}.config.system.build.toplevel"
#   nixos_partitioner_attr = ".#nixosConfigurations.${local.hostname}.config.system.build.diskoScript"
#   # extra_environment = {
#   #   SSH_KEY = "/run/secrets/terraform-oracle-ssh"
#   # }

#   install_user = "ubuntu"
#   install_ssh_key = file("/run/secrets/terraform-oracle-ssh")
#   nixos_facter_path = "./facter.json"

#   special_args = {
#     terraform = {
#       ip = oci_core_instance.ubuntu_instance.private_ip
#     }
#   }

#   # without flakes
#   # file can use (pkgs.nixos []) function from nixpkgs
#   #file                   = "${path.module}/../.."
#   #nixos_system_attr      = "config.system.build.toplevel"
#   #nixos_partitioner_attr = "config.system.build.diskoScript"

#   target_host            = oci_core_instance.ubuntu_instance.public_ip
#   # when instance id changes, it will trigger a reinstall
#   instance_id            = "abc"
#   # useful if something goes wrong
#   debug_logging          = true
#   # build the closure on the remote machine instead of locally
#   # build_on_remote        = true
#   # script is below
#   # extra_files_script     = "${path.module}/decrypt-ssh-secrets.sh"
#   # disk_encryption_key_scripts = [{
#   #   path   = "/tmp/secret.key"
#   #   # script is below
#   #   script = "${path.module}/decrypt-zfs-key.sh"
#   # }]
#   # Optional, arguments passed to special_args here will be available from a NixOS module in this example the `terraform` argument:
#   # { terraform, ... }: {
#   #    networking.interfaces.enp0s3.ipv4.addresses = [{ address = terraform.ip;  prefixLength = 24; }];
#   # }
#   # Note that this will means that your NixOS configuration will always depend on terraform!
#   # Skip to `Pass data persistently to the NixOS` for an alternative approach
#   #special_args = {
#   #  terraform = {
#   #    ip = "192.0.2.0"
#   #  }
#   #}
# }
