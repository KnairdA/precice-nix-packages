{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  precice,
  dealii,
  enable3d ? false,
}:

stdenv.mkDerivation {
  pname = "precice-dealii-adapter";
  version = "unstable-2022-09-23";

  src = fetchFromGitHub {
    owner = "precice";
    repo = "dealii-adapter";
    rev = "8ea1e573660a954000fdf272210d9d9ebdf3de96";
    hash = "sha256-BKQ8j/8vI15/w/T+L3t9GNQauRVzLY1yZ932Ty6XPRs=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [
    precice
    dealii
  ];

  cmakeFlags = lib.optionals enable3d [ "-DDIM=3" ];

  installPhase = ''
    mkdir -p $out/bin
    cp elasticity $out/bin/elasticity
  '';

  meta = {
    description = "A coupled structural solver written with the C++ finite element library deal.II";
    homepage = "https://precice.org/adapter-dealii-overview.html";
    license = with lib.licenses; [ lgpl3 ];
    maintainers = with lib.maintainers; [ cheriimoya ];
    mainProgram = "elasticity";
    platforms = lib.platforms.unix;
  };
}
