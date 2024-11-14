{ lib
, fetchPypi
, python311Packages
}:
python311Packages.buildPythonPackage rec {
  pname = "gfpgan";
  version = "1.3.8";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-IWGLBs6OpiMESMtSawEgBPI6mrlWtVyDP2m5/IpgxPk=";
  };

  nativeBuildInputs = with python311Packages; [
    setuptools-scm
  ];

  propagatedBuildInputs = with python311Packages; [
    basicsr
    facexlib
    lmdb
    numpy
    opencv4
    pyyaml
    scipy
    # tb-nightly
    tensorboard
    torch
    torchvision
    tqdm
    yapf
  ];

  pythonImportsCheck = [ "gfpgan" ];

  doCheck = false; # CBA to run the tests atm TODO: run the tests...
}
