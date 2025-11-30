{
  # last updated: 2025-11-30
  # branch: nixos-unstable
  nixpkgs = builtins.fetchTree {
    type = "github";
    owner = "nixos";
    repo = "nixpkgs";
    rev = "2fad6eac6077f03fe109c4d4eb171cf96791faa4";
    narHash = "sha256-sKoIWfnijJ0+9e4wRvIgm/HgE27bzwQxcEmo2J/gNpI=";
  };

  sops-nix-module = "${
    builtins.fetchTree {
      type = "github";
      owner = "Mic92";
      repo = "sops-nix";
      rev = "b80c966e70fa0615352c9596315678df1de75801";
      narHash = "sha256-TCVNCn/GcKhwm+WlSJEZEPW4ISQdU9ICIU3lTiOLBYc=";
    }
  }/modules/sops";

  disko-module = "${
    builtins.fetchTree {
      type = "github";
      owner = "nix-community";
      repo = "disko";
      rev = "af087d076d3860760b3323f6b583f4d828c1ac17";
      narHash = "sha256-TtcPgPmp2f0FAnc+DMEw4ardEgv1SGNR3/WFGH0N19M=";
    }
  }/module.nix";

  # nixos-hardware currently only has '16irx8h', not
  # my model '16irx8' (sans the 'h' at the end)
  getsuga-legion-module = "${
    builtins.fetchTree {
      type = "github";
      owner = "nixos";
      repo = "nixos-hardware";
      rev = "899dc449bc6428b9ee6b3b8f771ca2b0ef945ab9";
      narHash = "sha256-BWWnUUT01lPwCWUvS0p6Px5UOBFeXJ8jR+ZdLX8IbrU=";
    }
  }/lenovo/legion/16irx8h";
}
