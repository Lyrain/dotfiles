{ lib
, fetchPypi
, python311Packages
}:
python311Packages.buildPythonPackage rec {
  pname = "tb-nightly";
  version = "2.16.0a20240119";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "";
  };

  nativeBuildInputs = with python311Packages; [
    setuptools-scm
  ];

  propagatedBuildInputs = with python311Packages; [
  ];

  pythonImportsCheck = [ "tb-nightly" ];

  doCheck = false; # CBA to run the tests atm TODO: run the tests...
}
