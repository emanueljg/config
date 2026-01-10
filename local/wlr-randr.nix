{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.wlr-randr
  ];
}
