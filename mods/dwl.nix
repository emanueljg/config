{ pkgs, ... }:
{
  local.greetd.tuigreet.cmd = "dwl";
  programs.dwl = {
    enable = true;
    package = pkgs.dwl.overrideAttrs {
      src = pkgs.fetchFromGitHub {
        owner = "emanueljg";
        repo = "dwl";
        rev = "config";
        hash = "sha256-y5V7ODC9CTIWEocyXpIwlcHHuuXYjWu025fWjHDRHoc=";
        # hash = "sha256-hHeLQj7Pvxd23QvJM7OANIY3Q0I78CT3uaoCkmZN9Ik=";
        # hash = "sha256-TgyCpx5GBoF5CNsrMijseRl/r3ghSlQj6XKw2XHqAe8=";
        # hash = "sha256-Tjz24MXpcAx+JWL8obxOlhR8JhkZZsfA7BZ8ghwLRcw=";
      };
    };
  };
}
