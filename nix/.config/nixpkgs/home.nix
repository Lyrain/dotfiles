{ config, pkgs, ... }:

let
  strings = pkgs.lib.strings;

  python3-packages = pypkgs: with pypkgs; [
    flask
    pylint
    numpy
    pandas
    beautifulsoup4
    oauthlib
    requests
    requests_oauthlib
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
  ];
  python3-with-packages = with pkgs; python3.withPackages python3-packages;
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "moffor";
    homeDirectory = "/home/moffor";

    sessionVariables = {
      # Enable nicer touch support for firefox
      MOZ_USE_XINPUT2 = 1;
    };

    packages = with pkgs; [
      gnumake
      coreutils
      binutils
      pkgconfig
      glibc
      zlib
      exfat
      killall
      udiskie
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
      john
      hashcat
      sshuttle
      bind
      entr
      htop
      tmux
      screen
      jq
      yq
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
      geckodriver
      chromedriver

      # Documents
      texlive.combined.scheme-medium
      asciidoctor
      pandoc
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
      octaveFull
      R
      rPackages.tidyverse
      rstudio
      adoptopenjdk-hotspot-bin-8
      maven
      sbt
      gradle
      scala_2_11
      jetbrains.idea-community
      jetbrains.goland
      nixops
      nix-index
      terraform
      ruby
      ansible
      ansible-lint
      gcc
      gdb

      # GUI
      firefox
      google-chrome
      remmina
      slack
      keepassxc
      mpv
      vlc
      insomnia
      libreoffice
      wpa_supplicant_gui
      pavucontrol
      zoom-us
      mysql-workbench
      teams
      obsidian
      anki
      krita
      cutter
      aws-workspaces

      # Virt
      qemu
      virt-manager
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
