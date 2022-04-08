{ config, pkgs, ... }:

let
  lib = pkgs.lib;
  strings = lib.strings;

  bloodhound = import ./bloodhound.nix {};

  python3-packages = pypkgs: with pypkgs; [
    flask
    flask-cors
    pylint
    numpy
    pandas
    beautifulsoup4
    oauthlib
    requests
    requests_oauthlib
    urllib3
    jupyterlab
    python-dotenv
    pdfx
    ipython
    ipykernel
    bokeh
    matplotlib
    sqlalchemy
    dask
    distributed
    black
    mypy
    pytest
    tox
    ipdb
    pwntools
    unicorn
    capstone
    keystone-engine
    ropper
    tqdm
    docker
    h5py
  ];
  python3-with-packages = with pkgs; python39.withPackages python3-packages;
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  nixpkgs.overlays = [
    (self: super: {
      alacritty = super.alacritty.overrideAttrs (oldAttrs: rec {
        pname = "alacritty";
        version = "0.10.0";

        src = pkgs.fetchFromGitHub {
          owner = "alacritty";
          repo = pname;
          rev = "v${version}";
          sha256 = "sha256-eVPy47T2wcsN7NxtwMoyuC6loBVXsoJjJ/2q31i3vxQ=";
        };

        cargoDeps = oldAttrs.cargoDeps.overrideAttrs (_: {
          inherit src;

          outputHash = "sha256-B2+itbwd99G3m4cjctiBOpPq7qA9WmFJPe9vnYo6xc4=";
        });

        patches = [];
      });
    })

    (self: super: {
      weechat = super.weechat.override {
        configure = { availablePlugins, ...}: {
          scripts = with super.weechatScripts; [
            weechat-matrix
          ];
        };
      };
    })
  ];

  # xsession = {
  #   windowManager.xmonad = {
  #     enable = false;
  #     enableContribAndExtras = true;
  #     extraPackages = hp: [
  #       hp.dbus
  #       hp.monad-logger
  #       hp.xmonad-contrib
  #     ];
  #   };
  # };

  home = {
    username = "moffor";
    homeDirectory = "/home/moffor";

    sessionVariables = {
      # Enable nicer touch support for firefox
      MOZ_USE_XINPUT2 = 1;
    };

    packages = with pkgs; [
      # Core
      gnumake
      coreutils
      binutils
      pkgconfig
      glibc
      dmenu
      rofi
      rofi-emoji
      # i3lock
      # polybar
      dunst
      libnotify
      lxappearance
      # xmonad-with-packages

      # Essentials
      zlib
      exfat
      killall
      udiskie
      lsscsi
      lsof
      parted
      gparted
      hdparm
      smartmontools
      u3-tool
      fish
      tree
      wget
      curl
      lynx
      youtube-dl
      lame
      htop
      stow
      zip
      unzip
      rsync
      git
      neovim
      ripgrep
      lolcat
      ag
      fzf
      alacritty
      exa
      rxvt-unicode
      feh
      scrot
      imagemagick
      aspell
      ranger
      rizin # it's the new radare2
      jadx
      john
      hashcat
      sshuttle
      sshpass
      bind
      entr
      htop
      tmux
      screen
      ansifilter
      jq
      cfssl
      kubectl
      xxd
      file
      awscli2
      openssl
      openvpn
      upower
      acpi
      ffmpeg
      pciutils
      lshw
      lm_sensors
      docker-compose
      dive
      nmap
      telnet
      mpc_cli
      brightnessctl
      direnv
      qpdf
      poppler
      cairo
      # ghostscript # collision with texlive, that has ghostscript anyway
      geckodriver
      chromedriver
      exif
      exiftool
      inotify-tools
      arandr
      graphviz
      go-ethereum
      gocryptfs

      # Documents
      texlive.combined.scheme-full
      asciidoctor
      pandoc
      markdown-pp
      hugo

      # Manuals
      manpages
      stdmanpages
      zeal

      # Code
      conda
      python3-with-packages
      nodejs-14_x
      yarn
      go
      lua
      octaveFull
      R
      rPackages.tidyverse
      rstudio
      adoptopenjdk-hotspot-bin-8
      maven
      sbt
      gradle_6
      scala_2_11
      elixir
      neo4j
      nixops
      nix-index
      nix-prefetch-github
      nix-tree
      nixpkgs-review
      nixpkgs-fmt
      terraform
      cloud-nuke
      ruby
      gcc
      gdb

      # GUI
      firefox
      google-chrome
      remmina
      slack
      discord
      weechat
      keepassxc
      mpv
      vlc
      insomnia
      postman
      libreoffice
      wpa_supplicant_gui
      pavucontrol
      zoom-us
      sqlitebrowser
      teams
      obsidian
      anki
      krita
      blender
      kmag
      cutter
      aws-workspaces
      mate.caja
      bloodhound
      ghidra-bin
      burpsuite

      # Virt
      qemu
      virt-manager
      libguestfs-with-appliance
      nomad
      consul
      vault-bin

      # Networking
      wireshark
      termshark
    ];
  };

  # Services
  services.mpd = {
    enable = true;
    dbFile = "~/.config/mpd/mpd.db";
    musicDirectory = "~/Music";
    playlistDirectory = ~/.config/mpd/playlists;
    extraConfig = strings.concatStringsSep "\n" [
      ""
      "auto_update \"yes\""
      "audio_output {"
      "\ttype \"fifo\""
      "\tname \"Visualiser FIFO\""
      "\tpath \"/tmp/mpd.fifo\""
      "\tformat \"44100:16:2\""
      "}"
      ""
      "audio_output {"
      "\ttype \"pulse\""
      "\tname \"Pulse Audio\""
      "\tserver \"127.0.0.1\""
      "}"
    ];
  };
  # services.polybar = {
  #   enable = true;
  #   package = pkgs.polybar.override {
  #     i3GapsSupport = true;
  #     mpdSupport = true;
  #     pulseSupport = true;
  #   };
  #   script = strings.fileContents ~/.config/polybar/launch.sh;
  #   config = ~/.config/polybar/config.example;
  # };
  services.lorri.enable = true;

  # Programs
  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    ncmpcpp = {
      enable = true;
      package = pkgs.ncmpcpp.override {
        visualizerSupport = true;
      };
      mpdMusicDir = ~/Music;
      settings = {
        visualizer_in_stereo = "yes";
        visualizer_fifo_path = "/tmp/mpd.fifo";
        visualizer_output_name = "my_fifo";
        visualizer_sync_interval = "10";
      };
    };

    zathura = {
      enable = true;
      # package = pkgs.zathura.override {
      #   useMupdf = true;
      # };
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";
}
