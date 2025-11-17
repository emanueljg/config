{ pkgs, ... }:
{
  _file = ./somebar.nix;
  imports = [ ./local/somebar.nix ];
  local.programs.somebar = {
    enable = true;
    package = pkgs.somebar.overrideAttrs (prev: {
      src = pkgs.fetchFromSourcehut {
        owner = "~raphi";
        repo = "somebar";
        rev = "master";
        hash = "sha256-4s9tj5+lOkYjF5cuFRrR1R1S5nzqvZFq9SUAFuA8QXc=";
      };
    });
  };
}
