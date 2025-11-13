{
  modules,
  sourceModules,
  nixpkgs,
  ...
}:
{
  imports = with modules; [
    # this breaks the nice pattern we have going,
    # but I can't find out a nicer way of doing it right now.
    { _module.args = { inherit nixpkgs; }; }

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
