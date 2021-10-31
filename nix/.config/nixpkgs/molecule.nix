# with import <nixpkgs> {};

{ lib
, buildPythonPackage
, fetchPypi
, isPy27
, isPy3k
, setuptools_scm
, cerberus
, click
, click-help-colors
, cookiecutter
, enrich
, importlib-metadata
, jinja2
, packaging
, paramiko
, pluggy
, pyyaml
, rich
#, subprocess-tee
, ansible
, ansible-base
# Test
, ansi2html
, pexpect
, pytest-cov
, pytest-html
, pytest-mock
, pytest-xdist
, pytest
# Lint
#, flake8
# , pre-commit
# , yamllint
# Docs
# , sphinx
# , simplejson
# molecule-docker ???!
}:
let
  click8 = click.overridePythonAttrs (old: {
    version = "8.0.3";
  });
in
buildPythonPackage rec {
  pname = "molecule";
  version = "3.5.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-yCrwmeXAmY1+sWo79l7VpO3Zfjgk+5OM4BvwZKRs4Mo=";
  };

  propagatedBuildInputs = [
    cerberus
    click8
    click-help-colors
    cookiecutter
    enrich
    importlib-metadata
    jinja2
    packaging
    paramiko
    pluggy
    pyyaml
    rich
    setuptools_scm
    #subprocess-tee
    ansible
    ansible-base
  ];
  # ++ lib.optionals (isPy3k) [
  # ];

  # # AttributeError: 'KeywordMapping' object has no attribute 'get'
  # doCheck = !isPy27;
  doCheck = false;
  checkInputs = [
    pytest
    #flake8
  ];

  checkPhase = ''
    pytest
  '';

  # disabledTests = [
  #   # Disable tests that require network access and use httpbin
  # ];

  pythonImportsCheck = [ "molecule" ];

  meta = with lib; {
    description = "Molecule project is designed to aid in the development and testing of Ansible roles.";
    homepage = "https://github.com/ansible-community/molecule";
    license = licenses.mit;
    maintainers = with maintainers; [
      {
        email = "myles.offord@gmail.com";
        github = "lyrain";
        name = "Myles Offord";
      }
    ];
  };
}

