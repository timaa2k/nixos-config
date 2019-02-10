# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = false;

    kernelParams = [ "applesmc" ];

    #After 19.03 milestone for LUKS password dialog.
    #plymouth.enable = true;
    tmpOnTmpfs = true;
  };
 
  networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  
  #  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
  powerManagement.enable = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    acpid
    acpitool
    alacritty
    bashCompletion
    coreutils
    curl
    file
    fzf
    gitAndTools.gitFull
    gnupg
    htop
    lsof
    neovim
    mkpasswd
    mosh
    openssl
    powertop
    psmisc
    pwgen
    ranger
    tmux
    tree
    unzip
    utillinux
    vim
    wget 
    which
    zip

    chromium
    i3 i3lock i3status dmenu
    networkmanagerapplet networkmanager_openvpn
    slack
    vlc
    xdg_utils
    xfontsel
 
    gnome2.gtk gnome2.gnomeicontheme shared_mime_info

    dunst libnotify
    xautolock
    xss-lock

    xfce.exo
    xfce.gtk-xfce-engine
    xfce.gvfs
    xfce.terminal
    xfce.thunar
    xfce.thunar-volman
    xfce.xfce4icontheme
    xfce.xfce4settings
    xfce.xfconf
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.ssh.startAgent = true;

  # List services that you want to enable:
  services = {
    locate.enable = true;
    printing.enable = true;
    #openssh.enable = true;
    upower.enable = true;
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    #autorun = false;

    layout = "us";
    #xkbVariant = "mac";
    xkbOptions = "eurosign:e";
    autoRepeatDelay = 200;
    autoRepeatInterval = 25;

    libinput.enable = true;

    multitouch = {
      enable = true;
      ignorePalm = true;
      tapButtons = false;
      invertScroll = true;
    };

    #synaptics = {
    #  enable = true;
    #  palmDetect = true;
    #  scrollDelta = 100;
    #  tapButtons = false;
    #  twoFingerScroll = true;
    #  additionalOptions = ''
    #    Option "Thumbsize" "50"
    #    '';
    #};

    displayManager = {
      slim.enable = true; 
      slim.defaultUser = "tim";
      sessionCommands = ''
        # Set GTK_PATH so that GTK+ can find the Xfce theme engine.
        export GTK_PATH=${pkgs.xfce.gtk-xfce-engine}/lib/gtk-2.0
        # Set GET_DATA_PREFIX so that GTK+ can find the Xfce themes.
        export GTK_DATA_PREFIX=${config.system.path}
        # Set GIO_EXTRA_MODULES so that gvfs works.
        export GIO_EXTRA_MODULES=${pkgs.xfce.gvfs}/lib/gio/modules
        # Launch xfce settings daemon.
        ${pkgs.xfce.xfce4settings}/bin/xfsettingsd &
        # Network Manager Applet.
        ${pkgs.networkmanagerapplet}/bin/nm-applet &
        # Screen Locking (time-based & on suspend)
        ${pkgs.xautolock}/bin/autolock -detectsleep -time 1 \
        #  -locker "${pkgs.i3lock}/bin/i3lock -c 000070" &
        ${pkgs.xss-lock}/bin/xss-lock -- ${pkgs.i3lock}/bin/i3lock -c 000070 &
      '';
      job.logToJournal = true;
    };
    #desktopManager = {
    #  gnome2.enable = true;
    #};
    windowManager = {
      i3.enable = true;
      i3.configFile = "/etc/i3.conf";
      default = "i3";
    };
  };
  environment.etc."i3.conf".text = pkgs.callPackage ./i3-config.nix {};

  nixpkgs.config.allowUnfree = true;

  # Users
  users.mutableUsers = false;
  
  users.extraUsers.tim = {
    isNormalUser = true;
    home = "/home/tim";
    description = "Tim Weidner";
    extraGroups = [ "wheel" "networkmanager" ];
    hashedPassword = "$6$4RfV2SAFDtKDsBVz$FJnXrf1hiEUMxzKKfw.p0uwNtdXNcVoTDAGB0pkt1/p2Im9c232FzoSPP/NrsQqTMNPoTCjvF6JQsx6IuKCSb0";
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

}


