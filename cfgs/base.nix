{
  modules,
  sourceModules,
  ...
}:
{

  imports = [
    sourceModules.sops-nix
  ]
  ++ (with modules; [
    nixpkgs-var
    nix-helpers
    efi-grub
    wrap
    local
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
