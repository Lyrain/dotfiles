{ lib
, fetchPypi
, python311Packages
}:
python311Packages.buildPythonPackage rec {
  pname = "facexlib";
  version = "0.3.0";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-eueEpSDrUuBVg+i/n2j3f0UIMjmsdU1kbWNQF7Sed2M=";
  };

  nativeBuildInputs = with python311Packages; [
    setuptools-scm
  ];

  propagatedBuildInputs = with python311Packages; [
    torch
    torchvision
    numpy
    filterpy
    numba
    numpy
    numpy
    opencv4
    pillow
    scipy
    torchvision
    tqdm
    cython
  ];

  pythonImportsCheck = [ "facexlib" ];

  doCheck = false; # CBA to run the tests atm TODO: run the tests...
}
