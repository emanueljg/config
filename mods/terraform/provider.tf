provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  user_ocid = "ocid1.user.oc1..aaaaaaaaoopxaaik2iagw72v7cogisu4irq74aktmi6j4jdnpddcvs2zexqa"
  fingerprint = "4f:11:96:c0:37:67:b3:41:e4:89:b7:ca:c8:68:c4:b3"
  region = var.region
  private_key_path = "/run/secrets/oci-rsa-private.pem"
}


