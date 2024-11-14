{ lib
, fetchPypi
, python311Packages
}:
python311Packages.buildPythonPackage rec {
  pname = "realesrgan";
  version = "0.3.0";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-DTbalqufRHBxYG6R9QLM37CPgMyC7k+Mr3IMd0XM7H4=";
  };

  nativeBuildInputs = with python311Packages; [
    setuptools-scm
  ];

  propagatedBuildInputs = with python311Packages; [
    basicsr
    facexlib
    gfpgan
    numpy
    opencv4
    pillow
    torch
    torchvision
    tqdm
  ];

  pythonImportsCheck = [ "realesrgan" ];

  doCheck = false; # CBA to run the tests atm TODO: run the tests...
}
