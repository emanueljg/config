{
  local,
  remote,
  cfg,
  ...
}:
{
  imports = [
    cfg.pc
    remote.disko-zfs
  ]
  ++ (with local; [
    # meta
    hostnames.kagari
    systems.x86_64-linux

    # hardware
    disks.kagari
    hw.kagari
    nvidia

    # zfs
    disko-zfs
    zram-swap
    networking-hostids.kagari

    slack

    # gaming
    obs
    steam

    # development
    docker

    # misc. fixes
    network-wait-online-fix

    _1password

    stateversions."25-11"
  ]);

}
