{
  local.nixos-rebuild = {
    enable = true;
    hosts = [
      {
        name = "void";
        key = "dv";
        cmd = "sudo nixos-rebuild switch --attr nixosConfigurations.void";
      }
    ];
  };
}
