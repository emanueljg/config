{
  modules,
  sourceModules,
  configs,
  ...
}:
{
  imports = [
    configs.pc
  ]
  ++ (with modules; [
    # meta
    hostnames.getsuga
    systems.x86_64-linux

    # hardware
    sourceModules.getsuga-legion
    disks.getsuga
    hw.getsuga
    hw.nvidia

    nixos-rebuild.getsuga

    # core-specfic
    nginx-localhost

    # gaming
    gamescope
    obs

    # development
    docker
    terraform.oci

    # misc. fixes
    network-wait-online-fix

    stateversions."23-11"
  ]);

}
