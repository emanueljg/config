{
  local.nixos-rebuild = {
    enable = true;
    hosts = [
      {
        name = "getsuga";
        key = "dg";
        cmd = "sudo nixos-rebuild switch --attr nixosConfigurations.getsuga";
      }
      {
        name = "void";
        key = "dv";
        cmd = "nixos-rebuild switch --attr .nixosConfigurations.void --target-host 'ejg@void' --sudo";
      }
    ];
  };
}
