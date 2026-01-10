{
  local,
  remote,
  cfg,
  ...
}:
{
  imports = [
    cfg.pc
    remote.getsuga-legion
  ]
  ++ (with local; [
    # meta
    hostnames.getsuga
    systems.x86_64-linux

    # hardware
    disks.getsuga
    hw.getsuga
    nvidia
    swapfiles."32GiB"

    nixos-rebuild.getsuga

    # core-specfic
    nginx-localhost

    # gaming
    obs
    steam

    # development
    docker
    terraform.oci

    # misc. fixes
    network-wait-online-fix

    private.getsuga

    stateversions."23-11"
  ]);

}
