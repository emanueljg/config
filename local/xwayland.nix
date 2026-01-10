{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.xwayland ];
}
