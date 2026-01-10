{ pkgs, ... }:
{
  console = {
    earlySetup = true;
    font = "ter-i32b";
    packages = [ pkgs.terminus_font ];
  };
}
