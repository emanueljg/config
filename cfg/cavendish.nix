{
  local,
  cfg,
  ...
}:
{
  imports = [
    cfg.base
  ]
  ++ (with local; [
    hostnames."cavendish"
    systems.aarch64-linux
    disks."cavendish"

    terraform.ssh

    stateversions."25-11"

  ]);
}
