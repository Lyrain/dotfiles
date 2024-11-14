{ lib
, fetchPypi
, python311Packages
}:
python311Packages.buildPythonPackage rec {
  pname = "basicsr";
  version = "1.4.2";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-uJtZWofvlkzamRO02ZOA3bZVTJZVd8DBDLe3jjEwHoc=";
  };

  nativeBuildInputs = with python311Packages; [
    setuptools-scm
  ];

  propagatedBuildInputs = with python311Packages; [
    addict
    future
    lmdb
    numpy
    opencv4
    pillow
    pyyaml
    requests
    scikit-image
    scipy
    #tb-nightly
    tensorboard
    torch
    torchvision
    tqdm
    yapf
    cython
  ];

  pythonImportsCheck = [ "basicsr" ];

  doCheck = false; # CBA to run the tests atm TODO: run the tests...
}
