{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.xserver.videoDrivers = lib.mkForce [ "nvidia" ];
  hardware.nvidia.prime =
    let
      pCfg = config.hardware.nvidia.prime;
      primeEnabled = pCfg.nvidiaBusId != "" && (pCfg.intelBusId != "" || pCfg.amdgpuBusId != "");
    in
    lib.mkIf primeEnabled {
      offload.enable = false;
      sync.enable = true;
    };
  local.allowed-unfree.names = [
    "nvidia-x11"
    "nvidia-settings"
  ];
  hardware.graphics.enable32Bit = true;
  hardware.graphics.extraPackages = [ pkgs.nvidia-vaapi-driver ];
  environment.sessionVariables = {
    # used to use this when I had hyprland,
    # but dwl doesn't respect AQ_DRM_DEVICES, so
    # I just disabled the iGPU in BIOS.
    # AQ_DRM_DEVICES = "/dev/dri/card0:/dev/dri/card1";
    # MESA_VK_DEVICE_SELECT = "10de:28e0";

    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    NVD_BACKEND = "direct";
  };

}
