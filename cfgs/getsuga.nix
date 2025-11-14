{
  modules,
  sourceModules,
  configs,
  lib,
  nixpkgsHyprland,
  ...
}:
{
  imports = [
    configs.pc
    (
      { config, ... }:
      let
        pkgs' = import nixpkgsHyprland { inherit (config.nixpkgs) system; };
      in
      {
        local.programs.hyprland = {
          package = pkgs'.hyprland;
          plugins = lib.mkForce [ pkgs'.hyprlandPlugins.hy3 ];
        };
        # local.services.hyprpaper.package = pkgs'.hyprpaper;
      }
    )
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
