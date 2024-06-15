{
  lib,
  fetchFromGitHub,
  python3,
  precice,
  pkg-config,
  openmpi,
  openssh,
}:

python3.pkgs.buildPythonPackage rec {
  pname = "pyprecice";
  version = "3.1.0";

  src = fetchFromGitHub {
    owner = "precice";
    repo = "python-bindings";
    rev = "v${version}";
    hash = "sha256-5K6oVBhR6mBdkyOb/Ec0qg9x63tkoTnLIrE8dz8oCtc=";
  };

  nativeBuildInputs = with python3.pkgs; [
    cython
    openmpi
    openssh
    pkg-config
  ];

  propagatedBuildInputs = [
    python3.pkgs.numpy
    python3.pkgs.mpi4py
    precice
    python3.pkgs.pkgconfig
  ];

  doCheck = false;

  meta = with lib; {
    description = "Python language bindings for preCICE";
    homepage = "https://github.com/precice/python-bindings";
    license = [ licenses.lgpl3Only ];
    maintainers = with maintainers; [ conni2461 ];
    platforms = lib.platforms.unix;
  };
}
