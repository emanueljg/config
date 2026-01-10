{ custom, ... }:
{
  imports = [ custom.nixos-rebuild ];
  custom.nixos-rebuild = {
    enable = true;
    hosts = [
      {
        name = "getsuga";
        key = "dg";
        cmd = "sudo nixos-rebuild switch --attr cfgs.getsuga";
      }
      {
        name = "void";
        key = "dv";
        cmd = "nixos-rebuild switch --attr .cfgs.void --target-host 'ejg@void' --sudo";
      }
    ];
  };
}
