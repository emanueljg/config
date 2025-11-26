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
    hw.efi-grub
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
    kitty
    themes
  ]);

  _file = ./base.nix;
}
