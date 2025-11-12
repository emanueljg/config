{
  inputs,
  modules,
  configs,
  lib,
  ...
}:
cfg:
let
  parent = configs.base;
in
{

  system = "aarch64-linux";

  specialArgs = lib.recursiveUpdate parent.specialArgs {
    nixosModules = {
      disko = inputs.disko.nixosModules.default;
    };
  };

  modules =
    parent.modules
    ++ (with modules; [
      hostnames."cavendish"
      disks."cavendish"

      terraform.ssh

      stateversions."25-11"

    ]);
}
