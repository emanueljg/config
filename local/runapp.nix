{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.runapp ];
}
