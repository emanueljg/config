{
  modules,
  sourceModules,
  nixpkgs,
  ...
}:
{
  specialArgs = { inherit nixpkgs; };

  modules = with modules; [
    sourceModules.sops-nix
    nix-path
    hw.libinput
    hw.efi-grub
    wrap
    local
    keyboard
    enable-flakes
    garnix
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
  ];

}
