{
  inputs,
  modules,
  configs,
  lib,
  ...
}:
{
  imports = [
    configs.base
  ]
  ++ (with modules; [
    hostnames."cavendish"
    systems.aarch64-linux
    disks."cavendish"

    terraform.ssh

    stateversions."25-11"

  ]);
}
