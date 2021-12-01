# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  python38-packages = pypkgs: with pypkgs; [
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

  python38-with-packages = with pkgs; python38.withPackages python38-packages;

  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export _NV_PRIME_RENDER_OFFLOAD=1
    export _NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
    '';
in {
  imports =
    [ # Include the results of the hardware scan.
      "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/dell/xps/15-9550"
      /etc/nixos/hardware-configuration.nix
    ];

  # Garbage collect daily
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 3d";
    };
    autoOptimiseStore = true;
  };

  nixpkgs.config.allowUnfree = true;

  nixpkgs.config = {
    # zathura.useMupdf = true;
    packageOverrides = pkgs: rec {
      polybar = pkgs.polybar.override {
        i3Support = true;
        mpdSupport = true;
        pulseSupport = true;
      };
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    extraModprobeConfig = "options nvidia \"NVreg_DynamicPowerManagement=0x02\"\n";
    blacklistedKernelModules = [ "nouveau" ];
    kernelPackages = pkgs.linuxPackages_latest;

    # CPU stuff
    initrd.kernelModules = [ "intel_agp" "i915" ];
  };

  networking = {
    hostName = "daportbd9"; # Define your hostname.
    # networkmanager = {
    #   enable = true;
    #   # Ignore wireless so WPA supplicat can work
    #   unmanaged = [
    #     "*" "except:type:wwan" "except:type:gsm" "except:type:ethernet"
    #   ];
    # };

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    # interfaces.enp0s20f0u1 = {
    #   ipv4.addresses = [
    #     { address = "10.100.0.1"; prefixLength = 24; }
    #   ];
    # };
    # interfaces.enp0s20f0u2.useDHCP = true;
    interfaces.wlp2s0.useDHCP = true;

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    wireless = {
      interfaces = [ "wlp2s0" ];
      enable = true;  # Enables wireless support via wpa_supplicant.
      userControlled = {
        enable = true;
      };
      networks = import ./wireless-networks.nix;
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };

  # Configure X11
  services.xserver = {
    enable = true;
    layout = "gb";
    xkbOptions = "caps:escape";
    dpi = 192;

    videoDrivers = [ "nvidia" ];
    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;

    # Desktop environment
    desktopManager = {
      #xterm.enable = false;
      xfce.enable = true;
    };
    displayManager = {
        defaultSession = "none+i3";
    };

    windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        extraPackages = with pkgs; [
            dmenu
            rofi
            i3lock
            polybar
            dunst
            libnotify
            lxappearance
        ];
    };
  };

  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
    opengl.extraPackages = with pkgs; [
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-media-driver
    ];

    nvidia.modesetting.enable = true;
    nvidia.prime = {
      # offload.enable = true;
      sync.enable = true;

      # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
      # 01:00.0 3D controller: NVIDIA Corporation GM107M [GeForce GTX 960M] (rev a2)
      nvidiaBusId = "PCI:1:0:0";

      # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
      # 00:02.0 VGA compatible controller: Intel Corporation HD Graphics 530 (rev 06) (prog-if 00 [VGA controller])
      intelBusId = "PCI:0:2:0";
    };
  };

  services.udev.extraRules = ''
  # Remove NVIDIA USB xHCI Host Controller devices, if present
  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{remove}="1"

  # Remove NVIDIA USB Type-C UCSI devices, if present
  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{remove}="1"

  # Remove NVIDIA Audio devices, if present
  ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{remove}="1"

  # Enable runtime PM for NVIDIA VGA/3D controller devices on driver bind
  ACTION=="bind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="auto"
  ACTION=="bind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="auto"

  # Disable runtime PM for NVIDIA VGA/3D controller devices on driver unbind
  ACTION=="unbind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="on"
  ACTION=="unbind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="on"
  '';

  services.tlp = {
    enable = true;
    settings = {
      RUNTIME_PM_DRIVER_BLACKLIST = "nouveau mei_me";
    };
  };

  services.picom = {
    enable = true;

    shadow = true;
    #shadowRadius = 7;
    shadowOpacity = 0.0;
    shadowOffsets = [ (-7) (-7) ];
    shadowExclude = [
      "name = 'Notification'"
      "name = 'cpt_frame_window'"
      "class_g = 'Conky'"
      "class_g ?= 'Notify-osd'"
      "class_g = 'Cairo-clock'"
      "_GTK_FRAME_EXTENTS@:c"
    ];

    inactiveOpacity = 1.0;
    activeOpacity = 1.0;

    fade = true;
    fadeDelta = 4;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.nginx = {
    enable = true;
    virtualHosts."daportbd9.lan" = {
      root = "/var/www/";
      locations = {
        "/" = {
          proxyPass = "http://192.168.122.63";
        };
      };
    };
  };

  # Enable sound.
  sound.enable = true;

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1";

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
    podman.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.moffor = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "audio"
      "video"
      "lock"
      "power"
      "storage"
      "libvirtd"
      # "networkmanager"
      "nginx"
      "wireshark"
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nginx

    # Xorg
    xorg.xev
    xorg.xbacklight
    xorg.libxcb
    xorg.xcbutil
    xclip
    xsel
    xdotool

    # xfce
    xfce.xfce4-appfinder
    xfce.xfconf
    xfce.xfdesktop
    xfce.xfce4-dev-tools
    xfce.exo
    xfce.garcon
    xfce.xfce4-panel
    xfce.xfce4-power-manager
    xfce.xfce4-session
    xfce.xfce4-settings
    xfce.xfwm4
    xfce.libxfce4ui
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-battery-plugin
    xfce.xfce4-datetime-plugin
    xfce.xfce4-namebar-plugin
    xfce.xfce4-pulseaudio-plugin
    xfce.xfce4-sensors-plugin
    xfce.xfce4-systemload-plugin
    xfce.xfce4-taskmanager
    xfce.xfce4-volumed-pulse
    xfce.thunar

    # custom scripts
    nvidia-offload

    # Graphical
    breeze-gtk
    flat-remix-icon-theme
  ];

  # Fonts
  fonts.fonts = with pkgs; [
    source-code-pro
    noto-fonts
    noto-fonts-extra
    noto-fonts-emoji
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.dconf.enable = true;
  programs.steam.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    forwardX11 = true;
  };

  services.xrdp = {
    enable = false;
    defaultWindowManager = "${pkgs.xfce.xfce4-session}/bin/startxfce4";
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      # Nginx
      80

      # Ghost
      2368

      # Cassandra
      3389
      7000
      7001
      7199
    ];
    allowedTCPPortRanges = [
      # Development http servers
      { from = 3000; to = 3010; }
      { from = 4000; to = 4010; }
      { from = 8000; to = 9090; }
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}
