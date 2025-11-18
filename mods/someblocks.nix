{
  _file = ./someblocks.nix;

  imports = [
    ./local/someblocks
  ];

  local.programs.someblocks.enable = true;
}
