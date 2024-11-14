{ lib
, fetchFromGitHub
, python311Packages
}:
python311Packages.buildPythonPackage rec {
  pname = "tomesd";
  version = "0.1.3";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "dbolya";
    repo = "tomesd";
    rev = "refs/tags/v${version}";
    hash = "sha256-U3LN6KmQx/ulepFxjWgYHJl5g8j1U3HIGunpjcZBcos=";
  };

  nativeBuildInputs = with python311Packages; [
    setuptools-scm
  ];

  propagatedBuildInputs = with python311Packages; [
    torch
  ];

  pythonImportsCheck = [ "tomesd" ];
  doCheck = false; # CBA to run the tests atm TODO: run the tests...
}
