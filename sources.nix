{
  # branch: nixos-unstable
  nixpkgs = builtins.fetchTree {
    type = "github";
    owner = "nixos";
    repo = "nixpkgs";
    rev = "9da7f1cf7f8a6e2a7cb3001b048546c92a8258b4";
    narHash = "sha256-SlybxLZ1/e4T2lb1czEtWVzDCVSTvk9WLwGhmxFmBxI=";
  };

  nixpkgsHyprland = builtins.fetchTree {
    type = "github";
    owner = "nixos";
    repo = "nixpkgs";
    rev = "012b24398f02520866f846f61d61c40ca3242952";
    narHash = "sha256-ZUGGF6pPDCd0ME9aaPKxSr4ssQvBNtwWdgRoEiWBTqI=";
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
