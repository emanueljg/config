{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko-zfs = {
      url = "github:numtide/disko-zfs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.disko.follows = "disko";
    };
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:nixos/nixos-hardware";
    };
  };

  outputs = { self, ... }@inputs: let
    inherit (inputs.nixpkgs) lib;
    importer = import ./importer.nix { inherit lib; };
  in {
    # we explicitly use 'modules' instead of 'nixosModules' because 'nixosModules' doesn't allow nesting.
    # hopefully flake schemas will make this prettier 
    modules = {
      cfg = importer { root = ./cfg; };

      remote = {
        inherit (inputs.disko.nixosModules) disko;
        disko-zfs = inputs.disko-zfs.nixosModules.default;
        sops-nix = inputs.sops-nix.nixosModules.default;
        
        # not my model but close enough I guess
        getsuga-legion = inputs.nixos-hardware.lenovo-legion-16irx8h;
      };

      custom = importer { root = ./custom; };
      local = importer { root = ./local; };
      partial = importer { root = ./partial; };

    };

    nixosConfigurations = let
    in  builtins.mapAttrs (
      _: v: lib.nixosSystem {
        # system = null lets us to set system with a { nixpkgs.system = ... } module
        # https://github.com/NixOS/nixpkgs/blob/bc820e509bacaf06dd07b5fc807d8756179df95b/nixos/lib/eval-config.nix#L12
        system = null;
        modules = [ v ];
        specialArgs = self.modules;
      }
    ) self.modules.cfg;
    
  };
}
