{
  writeShellApplication,

  file,
  bat,
  chafa,
  imgcat,
}:
writeShellApplication {
  name = "fzf-preview";

  runtimeInputs = [
    file
    bat
    chafa
    imgcat
  ];

  # sans "nounset" (#KITTY* vars fail otherwise)
  bashOptions = [
    "errexit"
    "pipefail"
  ];

  text = builtins.readFile ./source.sh;
}
