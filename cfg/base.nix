{
  local,
  remote,
  custom,
  ...
}:
{

  imports = [
    remote.sops-nix
    custom.wrap
  ]
  ++ (with local; [
    nixpkgs-var
    nix-helpers
    efi-grub
    keyboard
    enable-flakes
    pkgs
    swedish-locale
    user
    sops
    bat
    nnn
    aliases
    access-tokens
    direnv
    keep-outputs-and-derivations
    starship
    git
    pass
    gpg
    helix
    zsh
    foot
    themes
    fzf-preview
    print-colors
  ]);

  _file = ./base.nix;
}
