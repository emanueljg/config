{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.glab
  ];
}
