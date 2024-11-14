{ pkgs, ... }:

let
  lib = pkgs.lib;

  bloodhound = import ./bloodhound.nix {};

  username = "moffor";
  homeDirectory = "/home/moffor";

  # python3WithOverrides = with pkgs; python311.override {
  #   packageOverrides = lib.composeManyExtensions [
  #     (self: super: {
  #         torch = super.torch.overridePythonAttrs (oldAttrs: rec {
  #             # version = "2.1.2";
  #             # src = fetchFromGitHub {
  #             #   owner = "pytorch";
  #             #   repo = "pytorch";
  #             #   rev = "refs/tags/v${version}";
  #             #   fetchSubmodules = true;
  #             #   hash = "sha256-E/GQCRWBf3hYsDCCk0twaL9gkVOCEQeCvO3Va+jgIdE=";
  #             # };

  #             # GeForce GTX 980 - Nvidia GM204
  #             # Maxwell Architecture
  #             # Consider trying 5.3, should be supported for Maxwell
  #             preConfigure = ''
  #               export TORCH_CUDA_ARCH_LIST="5.2"
  #               export CUPTI_INCLUDE_DIR=${pkgs.cudaPackages_12.cuda_cupti.dev}/include
  #               export CUPTI_INCLUDE_DIR=${pkgs.cudaPackages_12.cuda_cupti.lib}/lib
  #               export CUDNN_INCLUDE_DIR=${pkgs.cudaPackages_12.cudnn.dev}/include
  #               export CUDNN_LIB_DIR=${pkgs.cudaPackages_12.cudnn.lib}/lib
  #             '';
  #         });

  #         tomesd = pkgs.callPackage ./tomesd.nix { python311Packages = self; };
  #         blendmodes = pkgs.callPackage ./blendmodes.nix { python311Packages = self; };
  #         facexlib = pkgs.callPackage ./facexlib.nix { python311Packages = self; };
  #         basicsr = pkgs.callPackage ./basicsr.nix { python311Packages = self; };
  #         gfpgan = pkgs.callPackage ./gfpgan.nix { python311Packages = self; };
  #         realesrgan = pkgs.callPackage ./realesrgan.nix { python311Packages = self; };
  #     })
  #   ];
  # };

  python3-packages = pypkgs: with pypkgs; [
    beautifulsoup4
    black
    bokeh
    capstone
    flask
    flask-cors
    ipdb
    ipython
    keystone-engine
    lief
    matplotlib
    mypy
    numpy
    oauthlib
    pandas
    odfpy # ODS libreoffice calc files
    pyarrow
    fastparquet
    pdfx
    pwntools
    pylint
    pytest
    python-dotenv
    pyyaml
    requests
    requests_oauthlib

    pygame

    ropper # Security...?

    sqlalchemy
    tox
    tqdm
    twisted
    unicorn
    urllib3
    pyyaml
    gitpython
    # selenium

    # bottle
    # puremagic
    # xlsxwriter
    # pycryptodomex
    # pypykatz

    # torch
    # torchsde
    # torchvision
    # open-clip-torch
    # pytorch-lightning
    # opencv4
    # diffusers
    # accelerate
    # transformers
    # scipy
    # scikit-image
    # pillow
    # einops
    # gradio
    # omegaconf
    # kornia
    # lark
    # clean-fid
    # jsonmerge
    # torchdiffeq
    # clip
    # resize-right
    # piexif
    # aenum
    # inflection
    # gdown
    # xformers
    # rich

    # blendmodes
    # facexlib
    # tomesd
    # gfpgan
    # realesrgan
  ];
  python3-with-packages = pkgs.python311.withPackages python3-packages;
in
{
  nixpkgs.overlays = [
    (self: super: {
        vlc = super.vlc.override { # not sure if this works?
            libbluray = super.libbluray.override {
              withJava = true;
              withAACS = true;
              withBDplus = true;
            };
        };
    })
  ];

  home = {
    username = username;
    homeDirectory = homeDirectory;

    packages = with pkgs; [
      # Essentials
      gnumake
      cmake
      ninja
      gnupg
      coreutils
      binutils
      pkg-config
      glibc
      dmenu
      rofi
      rofi-emoji
      dunst
      libnotify
      libpcap

      git
      git-lfs
      tmux
      file
      zlib
      exfat
      killall
      udisks2
      usbutils
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
      lame
      htop

      stow # BYE BYE SOON

      zip
      unzip
      p7zip
      rar
      rsync
      ripgrep
      fd
      f2
      fzf
      alacritty
      kitty
      eza # exa is unmaintained, :(
      rxvt-unicode
      feh
      flameshot
      imagemagick
      aspell
      ranger # trying out yazi, didn't like felix-fm
      yazi
      ueberzug
      sshuttle
      sshpass
      bind
      entr
      jq
      # screen
      # ansifilter
      # cfssl
      # kubectl
      # eksctl
      # kubernetes-helm
      # cilium-cli
      # terraform
      # cloud-nuke

      # docker-compose
      dive

      firecracker
      firectl

      openssl
      openvpn
      wireguard-tools
      upower
      acpi
      ffmpeg
      pciutils
      lshw
      lm_sensors
      inetutils
      mpc_cli
      brightnessctl
      direnv

      qpdf
      poppler
      cairo
      geckodriver
      chromedriver
      exif
      exiftool
      inotify-tools
      arandr
      graphviz
      gocryptfs
      veracrypt
      # zulucrypt :sad.jpg:
      dfu-util

      # GPU / Graphics
      clinfo

      # Machine Learning
      # mkl # clashes with llvmPackages.openmp
      # llvmPackages.openmp

      # Security
      # burpsuite
      # jadx
      # nuclei
      # sleuthkit
      # zap
      bloodhound
      clamav
      cutter
      ghidra-bin
      hashcat
      imhex
      john
      pwndbg
      rizin # it's the new radare2
      xxd
      nmap

      # Documents
      texlive.combined.scheme-full
      # asciidoctor
      pandoc
      plantuml
      evince
      okular
      libreoffice

      # Accounting
      hledger
      hledger-ui
      hledger-web
      gnucash

      # Manuals
      man-pages
      stdmanpages
      zeal

      # Code
      python3-with-packages

      lua
      # ruby # remove???
      nodejs_18
      maven
      sbt
      coursier
      leiningen
      # scala_2_
      jetbrains-toolbox
      jetbrains.idea-ultimate
      neo4j

      # Maybe just do these in nix shell flakes per-project?
      # gcc
      # ccls
      # gdb

      # go
      # gopls # go language server
      # delve
      # gdlv # GUI for delve

      nix-index
      nix-prefetch-github
      nix-tree
      nixops_unstable_minimal
      deploy-rs
      nixpkgs-fmt

      # File & Utilities
      mate.caja
      czkawka
      keepassxc

      # Browsers
      firefox
      google-chrome
      chromium
      brave

      remmina

      # thunderbird

      wpa_supplicant_gui
      pulseaudioFull
      pavucontrol
      paprefs
      sqlitebrowser
      anki
      kmag

      # Media
      mpv
      vlc
      krita
      obs-studio
      kdenlive
      youtube-dl
      handbrake
      makemkv
      blender
      ruffle
      audacity

      amidst
      plover.dev
      kicad
      geeqie

      lxappearance
      gnome.dconf-editor
      gnome.simple-scan

      # Android
      # android-studio
      # android-tools

      # Virt
      qemu
      libguestfs-with-appliance

      pcsx2

      # Networking
      wireshark
      termshark

      # Non Nix managed packages (Flatpak)
      #
      # com.amazon.Workspaces
      # com.discordapp.Discord
      # com.valvesoftware.Steam
      # net.runelite.RuneLite
      # org.onlyoffice.desktopeditors
      # org.polymc.PolyMC
      # us.zoom.Zoom
      # md.obsidian.Obsidian
    ];
  };

  # Services
  services.mpd = {
    enable = true;
    dbFile = "/home/moffor/.config/mpd/mpd.db";
    musicDirectory = "/home/moffor/Music";
    playlistDirectory = "/home/moffor/.config/mpd/playlists";

    # network.listenAddress = "0.0.0.0";
    # network.port = 6600;

    extraConfig = lib.strings.concatStringsSep "\n" [
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
      "}"

      # "audio_output {"
      # "\ttype \"httpd\""
      # "\tname \"HTTP Stream\""
      # "\tencoder \"opus\"" # optional"
      # "\tport \"8000\""
      # "\tquality \"5.0\"" # do not define if bitrate is defined
      # "\tbitrate \"128000\"" # do not define if quality is defined
      # "\tformat \"48000:16:1\""
      # "\talways_on \"yes\"" # prevent MPD from disconnecting all listeners when playback is stopped.
      # "\ttags \"yes\"" # httpd supports sending tags to listening streams.
      # "}"
    ];
  };

  services.syncthing = {
      enable = false;
  };

  services.picom = {
    enable = true;

    fade = true;
    fadeSteps = [ 0.05 0.05 ];
    fadeDelta = 8;

    shadow = true;
    shadowOpacity = 0.0;
    shadowOffsets = [ (-7) (-7) ];
    shadowExclude = [
      "name = 'Notification'"
      "name = 'cpt_frame_window'"
      "class_g = 'Conky'"
      "class_g ?= 'Notify-osd'"
      "_GTK_FRAME_EXTENTS@:c"
    ];

    activeOpacity = 1.0;
    inactiveOpacity = 1.0;
  };

  # Programs
  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    java = {
        enable = true;
        package = pkgs.temurin-bin-21;
    };

    neovim = {
      enable = true;
      extraLuaConfig = ''vim.cmd("source ${homeDirectory}/dotfiles/nvim/.config/nvim/init.lua")'';
      withPython3 = true;
      withNodeJs = true;
      plugins = with pkgs.vimPlugins; [
        gruvbox
        airline
        vim-rooter

        #nvim-treesitter.withAllGrammars
        (nvim-treesitter.withPlugins (plugins: with plugins; [
            c
            cpp
            java
            javascript
            lua
            rust
            scala
            elixir
            hcl
            clojure
        ]))
        playground

        vim-fugitive
        vim-surround
        vim-repeat

        telescope-nvim
        plenary-nvim
        emmet-vim
        undotree

        mason-nvim
        mason-lspconfig-nvim

        nvim-lspconfig
        nvim-cmp
        cmp-buffer
        cmp-path
        cmp-nvim-lsp
        cmp-nvim-lua
        cmp-vsnip
        vim-vsnip
        nvim-metals
        luasnip

        # nvim-nio
        # nvim-dap
        # nvim-dap-ui
      ];
    };

    ncmpcpp = {
      enable = true;
      package = pkgs.ncmpcpp.override {
        visualizerSupport = true;
      };
      mpdMusicDir = "${homeDirectory}/Music";
      settings = {
        visualizer_in_stereo = "yes";
        visualizer_fifo_path = "/tmp/mpd.fifo";
        visualizer_output_name = "my_fifo";
        visualizer_sync_interval = "10";
        visualizer_type = "spectrum";
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
  home.stateVersion = "22.11";
}
