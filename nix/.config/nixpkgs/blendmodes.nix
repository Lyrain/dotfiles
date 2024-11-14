{ lib
, fetchPypi
, python311Packages
}:
python311Packages.buildPythonPackage rec {
  pname = "blendmodes";
  version = "2024";
  format = "pyproject";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-oVp5CfiT/UDwOumiCpGt9L7osCxI8Ky90rJa6oEuf9I=";
  };

  nativeBuildInputs = with python311Packages; [
    poetry-core
  ];

  propagatedBuildInputs = with python311Packages; [
    numpy
    aenum
    pillow
    deprecation
  ];

  pythonImportsCheck = [ "blendmodes" ];

  doCheck = false; # CBA to run the tests atm TODO: run the tests...
}
