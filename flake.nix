{
  inputs = {
    nixos-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixos-unstable";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixos-unstable";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
    };

    archiver = {
      url = "github:emanueljg/archiver";
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      # not overriden, see:
      # https://github.com/thiagokokada/nix-alien?tab=readme-ov-file#nixos-installation-with-flakes
      # inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    { self, nixos-unstable, ... }@inputs:
    let
      inherit (nixos-unstable) lib;
      systemPkgs = lib.getAttrs [ "x86_64-linux" ] nixos-unstable.legacyPackages;
    in
    {
      modules =
        let
          modulesToAttrs =
            cursor:
            let
              paths = builtins.readDir cursor;
            in
            if paths ? "default.nix" then
              (import cursor)
            else
              (lib.filterAttrsRecursive (_: v: v != null) (
                lib.mapAttrs' (
                  n: v:
                  lib.nameValuePair (if v == "regular" then (lib.removeSuffix ".nix" n) else n) (
                    if v == "regular" && !(lib.hasSuffix ".nix" n) then
                      null
                    else if v == "regular" then
                      (import "${cursor}/${n}")
                    else if v == "directory" then
                      (modulesToAttrs "${cursor}/${n}")
                    else
                      (builtins.throw "")
                  )
                ) paths
              ));
        in
        modulesToAttrs ./nixos;

      configs =
        let
          cfgDir = ./cfgs;
        in
        lib.mapAttrs' (
          n: v:
          lib.nameValuePair (lib.removeSuffix ".nix" n) (
            let
              x = (
                (import "${cfgDir}/${n}") {
                  inherit inputs lib self;
                  inherit (self) modules configs;
                }
              );
            in
            if builtins.isFunction x then lib.fix x else x
          )
        ) (builtins.readDir cfgDir);

      packages = builtins.mapAttrs (
        system: pkgs:
        lib.concatMapAttrs (
          hostName: cfg:
          lib.mapAttrs' (
            n: v: lib.nameValuePair ("${hostName}-${n}") (v.finalPackage.passthru.image)
          ) cfg.config.local.wrap.wraps
        ) self.nixosConfigurations
      ) systemPkgs;

      apps = builtins.mapAttrs (
        system: pkgs:
        {
          garnixEncrypt = {
            type = "app";
            program = lib.getExe (
              pkgs.writeShellApplication {
                name = "garnix-encrypt";
                runtimeInputs = [ pkgs.age ];
                text = ''
                  age -r "$(curl 'https://garnix.io/api/keys/emanueljg/config/repo-key.public')" "$1" > "$2"
                '';
              }
            );
          };
        }
        // (lib.mapAttrs' (
          pkgName: pkg:
          lib.nameValuePair "${pkgName}-dockerpush" {
            type = "app";
            program = lib.getExe (
              pkgs.writeShellApplication {
                name = "${pkgName}-dockerpush";
                runtimeInputs = [ pkgs.age ];
                text =
                  let
                    outHash = lib.removeSuffix ("-${pkg.name}") (lib.removePrefix "/nix/store/" pkg.outPath);
                  in
                  ''
                    nix build "github:emanueljg/config/$GARNIX_COMMIT_SHA#${pkgName}" \
                      --option max-jobs 0 \
                      --option builders "" \
                      --extra-experimental-features 'nix-command flakes'
                    ls -al
                    # curl --verbose 'https://cache.garnix.io/${outHash}.narinfo'
                    # download_url="$(curl 'https://cache.garnix.io/${outHash}.narinfo' | grep -Po '(?<=URL: ).*')"
                    # echo "$download_url"
                    # curl "$download_url" | xz -dc | nix-store --restore 'image.tar.gz'
                  '';
              }
            );
          }
        ) self.packages.${system})

      ) systemPkgs;

      nixosConfigurations =
        builtins.removeAttrs (builtins.mapAttrs (_: v: lib.nixosSystem v) self.configs)
          [
            "base"
            "pc"
          ];
      formatter = builtins.mapAttrs (_: pkgs: pkgs.nixfmt-rfc-style) systemPkgs;
    };
}
