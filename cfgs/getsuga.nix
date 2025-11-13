{
  modules,
  sourceModules,
  configs,
  ...
}:
cfg:
let
  parent = configs.pc;
in
{
  inherit (parent) system specialArgs;

  modules =
    parent.modules
    ++ (with modules; [
      hostnames.getsuga
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
