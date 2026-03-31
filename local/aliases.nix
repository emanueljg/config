{
  environment.shellAliases = {
    "..." = "cd ../..";

    "e" = "$EDITOR";

    "s" = "sudo";
    "se" = "sudoedit";

    "sd" = "sudo systemctl";
    "sds" = "sd start";
    "sdr" = "sd restart";
    "sdst" = "sd status";
    "sdj" = "sudo journalctl";
    "sdju" = "sdj -u";
    "sdjuf" = "sdj -fu";

    "rune" = "grep -rwne";

    "nrs" = "s nixos-rebuild switch --flake /home/ejg/nixos";
    "nfu" = "nix flake update";
    "nfc" = "nix flake check";
  };
}
