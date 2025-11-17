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
        hash = "sha256-NKNWeGN+Z/tWQ/WCnEdXFwimLNRdqKLoGNCTQnoUUlI=";
        # hash = "sha256-NKNWeGN+Z/tWQ/WCnEdXFwimLNRdqKLoGNCTQnoUUlI=";
      };
    };
  };
}
