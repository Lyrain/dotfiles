{ config, pkgs, ... }:

let
  lib = pkgs.lib;
  strings = lib.strings;

  secrets = import ./secrets.nix {};

  bloodhound = import ./bloodhound.nix {};

  kubectl-doctor = import ./kubectl-doctor.nix {};

  awscli2 = import ./awscli2.nix {
    inherit lib;
    python3 = pkgs.python3;
    groff = pkgs.groff;
    less = pkgs.less;
    fetchFromGitHub = pkgs.fetchFromGitHub;
  };

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
    netaddr
    libvirt
    pyyaml
    kubernetes
    jsonpatch
    folium
    twisted
  ];
  python3-with-packages = with pkgs; python39.withPackages python3-packages;
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  nixpkgs.overlays = [
    (self: super: {
      weechat = super.weechat.override {
        configure = { availablePlugins, ...}: {
          scripts = with super.weechatScripts; [
            weechat-matrix
          ];
        };
      };
    })

    (self: super: {
      polymc = super.polymc.override {
        msaClientID = secrets.msaClientID;
      };
    })
  ];

  # xsession = {
  #   windowManager.xmonad = {
  #     enable = true;
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
      dunst
      libnotify
      libpcap
      lxappearance
      mlocate
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
      p7zip
      rsync
      git
      neovim
      ripgrep
      rename
      lolcat
      silver-searcher
      fzf
      alacritty
      exa
      rxvt-unicode
      feh
      digikam
      scrot
      imagemagick
      zbar
      aspell
      ranger
      ueberzug
      mc
      rizin # it's the new radare2
      jadx
      john
      hashcat
      sleuthkit
      nuclei
      clinfo
      sshuttle
      sshpass
      bind
      entr
      tmux
      screen
      ansifilter
      jq
      cfssl
      kubectl
      kubectl-doctor
      eksctl
      kubernetes-helm
      cilium-cli
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
      inetutils
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
      gocryptfs

      # Documents
      texlive.combined.scheme-full
      asciidoctor
      pandoc
      markdown-pp
      hugo
      plantuml
      evince
      okular

      # Manuals
      man-pages
      stdmanpages
      zeal

      # Code
      conda
      python3-with-packages
      poetry
      nodejs-14_x
      yarn
      go
      gopls # go language server
      lua
      cargo
      rustc
      octaveFull
      R
      rPackages.tidyverse
      rstudio
      openjdk17
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
      leiningen
      gcc
      gdb
      pwndbg
      sonar-scanner-cli

      # GUI
      firefox
      google-chrome
      chromium
      remmina
      slack
      weechat
      keepassxc
      mpv
      vlc
      insomnia
      postman
      libreoffice
      taskjuggler
      wpa_supplicant_gui
      pavucontrol
      sqlitebrowser
      teams
      obsidian
      vscode
      anki
      krita
      kdenlive
      cdrtools
      blender
      kmag
      cutter
      mate.caja
      bloodhound
      ghidra-bin
      burpsuite
      zap
      gnome.dconf-editor
      # multimc replace by polymc due to politics https://github.com/NixOS/nixpkgs/pull/154051
      polymc

      # Android
      android-studio
      android-tools

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

      # Non Nix managed packages (Flatpak)
      #
      # us.zoom.Zoom
      # com.discordapp.Discord
      # com.valvesoftware.Steam
      # org.onlyoffice.desktopeditors
      # com.amazon.Workspaces
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
