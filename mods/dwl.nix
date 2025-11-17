{ pkgs, ... }:
{
  local.greetd.tuigreet.cmd = "dwl -s somebar";
  programs.dwl = {
    enable = true;
    package = pkgs.dwl.overrideAttrs {
      src = pkgs.fetchFromGitHub {
        owner = "emanueljg";
        repo = "dwl";
        rev = "config";
        hash = "sha256-1emxFQKgdu9jkkKvW1VPQdM9PhKKc1vunxLKS4UbWoU=";
        # hash = "sha256-NKNWeGN+Z/tWQ/WCnEdXFwimLNRdqKLoGNCTQnoUUlI=";
        # hash = "sha256-NKNWeGN+Z/tWQ/WCnEdXFwimLNRdqKLoGNCTQnoUUlI=";
      };
    };
  };
}
