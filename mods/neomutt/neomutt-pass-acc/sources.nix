{
  # track: nixos-unstable
  nixpkgs = builtins.fetchTree {
    type = "github";
    owner = "nixos";
    repo = "nixpkgs";
    rev = "08dacfca559e1d7da38f3cf05f1f45ee9bfd213c";
    narHash = "sha256-o9KF3DJL7g7iYMZq9SWgfS1BFlNbsm6xplRjVlOCkXI=";
  };

  # track: master
  nix-fetchers = builtins.fetchTree {
    type = "github";
    owner = "emanueljg";
    repo = "nix-fetchers";
    rev = "dc0bac85caa1655a06f6a640e8930989e7044e3e";
    narHash = "sha256-YED9mwcsLOOlqNmmcCfMv+jZcIawF1KaMHiU93PMWX8=";
    # narHash = "sha256-o9KF3DJL7g7iYMZq9SWgfS1BFlNbsm6xplRjVlOCkXI=";
  };
}
