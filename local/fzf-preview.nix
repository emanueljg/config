{ custom, ... }:
{
  imports = [ custom.fzf-preview ];
  custom.programs.fzf-preview.enable = true;
}
