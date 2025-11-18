{
  stdenv,
  fetchFromSourcehut,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "someblocks";
  version = "1.0.1";

  src = fetchFromSourcehut {
    owner = "~raphi";
    repo = "someblocks";
    rev = finalAttrs.version;
    sha256 = "sha256-pUdiEyhqLx3aMjN0D0y0ykeXF3qjJO0mM8j1gLIf+ww=";
  };

  dontConfigure = true;
  NIX_CFLAGS_COMPILE = [ "-Wno-unused-result" ];
  installFlags = [ "PREFIX=$(out)" ];

})
