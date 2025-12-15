{
  lib,
  fetchFromGitHub,
  rustPlatform,
  gpgme,
  pkg-config,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "neomutt-pass-acc";
  version = "0.1.0";

  src = ./.;
  cargoHash = "sha256-l7ktZRHmAaFf88uyKVRuGvkE6LrBlZmq+sj3qB0MGCY=";

  buildInputs = [
    gpgme.dev
  ];

  nativeBuildInputs = [
    pkg-config
  ];

  meta.mainProgram = "neomutt-pass-acc";

  # cargoHash = "sha256-9atn5qyBDy4P6iUoHFhg+TV6Ur71fiah4oTJbBMeEy4=";

})
