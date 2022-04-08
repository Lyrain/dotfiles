{ pkgs ? import <nixpkgs> { } }:
let
  inherit (pkgs) fetchurl;
in
pkgs.stdenv.mkDerivation rec {
  pname = "bloodhound";
  binaryName = "BloodHound";
  version = "4.1.0";
  src = fetchurl {
    url = "https://github.com/BloodHoundAD/BloodHound/releases/download/${version}/BloodHound-linux-x64.zip";
    sha256 = "sha256-Sxll+yjFCv9jK65R4r/uFTAJeX8rV2kyB200cvmErmY=";
  };

  buildInputs = with pkgs; [
    gtk3
  ];

  nativeBuildInputs = with pkgs; [
    makeWrapper
    unzip
  ];

  rpath = with pkgs; lib.makeLibraryPath [
    alsa-lib # alsaLib ???
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    dbus
    expat
    gdk-pixbuf
    glib
    # glibc
    gtk3
    libGL
    libdrm
    xorg.libxcb # libxcb OR xorg.libxcb ???
    libxkbcommon
    mesa
    nspr
    nss
    gnome2.pango # pango or gnome2.pango ???

    ffmpeg
    electron
    xorg.libX11
    xorg.libXScrnSaver
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    xorg.libxshmfence
    # xorg.libXi
    # libudev
  ] + ":${stdenv.cc.cc.lib}/lib64";

  # dontConfigure = true;
  dontUnpack = true;
  dontBuild = true;
  dontPatchElf = true;

  installPhase = with pkgs; ''
    runHook preInstall

    unzip $src
    mkdir -p $out
    mkdir -p $out/{bin,lib/${binaryName}}
    mv BloodHound-linux-x64/* $out/lib/${binaryName}
    chmod +x $out/lib/${binaryName}/${binaryName}

    patchelf --set-interpreter ${stdenv.cc.bintools.dynamicLinker} \
       $out/lib/${binaryName}/${binaryName}

    makeWrapper $out/lib/${binaryName}/${binaryName} $out/bin/${binaryName} \
      --prefix XDG_DATA_DIRS : $GSETTINGS_SCHEMAS_PATH \
      --prefix PATH : ${lib.makeBinPath [xdg-utils]} \
      --prefix LD_LIBRARY_PATH : ${rpath}

    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "Six Degrees of Domain Admin";
    homepage = "https://github.com/BloodHoundAD/BloodHound";
    downloadPage = "https://github.com/BloodHoundAD/BloodHound/release";
    license = licenses.gpl3;
    maintainers = [{
      email = "myles.offord@gmail.com";
      github = "Lyrain";
      githubId = 123123;
      name = "Myles Offord";
    }];
    platforms = [ "x86_64-linux" ];
  };
}
