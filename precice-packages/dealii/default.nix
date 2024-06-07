{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  gcc,
  openmpi,
  boost, # dont use bundled boost
  adolc,
  arpack,
  assimp,
  liblapack,
  cgal_5,
  gmp,
  mpfr,
  gmsh,
  gsl,
  scalapack,
  blacs,
  metis,
  hdf5-mpi,
  p4est,
  petsc,
  zlib,
  openssh,
  perl
}:

stdenv.mkDerivation rec {
  pname = "dealii";
  version = "9.5.2";

  src = fetchFromGitHub {
    owner = "dealii";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-m2+1HCAkfY6w3QBT4fuz5dm7E3qurvukRf9nI6xyfpY=";
  };

  nativeBuildInputs = [
    cmake
    gcc
    openmpi
    boost
    adolc
    arpack
    assimp
    liblapack
    cgal_5
    gmp
    mpfr # for cgal gmp and mpfr are also required
    gmsh
    gsl
    scalapack
    metis
    hdf5-mpi
    p4est
    petsc
    zlib
    perl
  ];

  cmakeFlags = [
    "-DDEAL_II_WITH_MPI=ON"
    "-DDEAL_II_HAVE_CXX17=ON"
  ];

  doCheck = true;

  nativeCheckInputs = [ openssh ];

  meta = {
    description = "An open source finite element library";
    homepage = "https://www.dealii.org/";
    license = with lib.licenses; [ lgpl21Only ];
    maintainers = with lib.maintainers; [ cheriimoya ];
    platforms = lib.platforms.unix;
  };
}
