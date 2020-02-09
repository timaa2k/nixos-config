# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./user-configuration.nix
      "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/release-19.09.tar.gz}/nixos"
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_4_19;
    cleanTmpDir = true;
    plymouth.enable = true;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "mbp";
    networkmanager.enable = true;
    networkmanager.appendNameservers = [ "1.1.1.1" "8.8.8.8" ];
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  i18n = {
    # HiDPI Font
    consoleFont = "latarcyrheb-sun32";
    #consoleKeyMap = "us";
    consoleUseXkbConfig = true;
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  };

  time.timeZone = "Europe/Berlin";

  environment.systemPackages = with pkgs; [

    # essential
    bind
    coreutils
    curl
    dcfldd
    file
    fd
    gitAndTools.gitFull
    gitAndTools.hub
    lsof
    pciutils
    psmisc
    ripgrep
    tmux
    tree
    usbutils
    utillinux
    vim
    wget

    # monitor 
    atop
    ethtool
    htop
    iftop
    iotop
    ncdu
    nethogs
    sysstat
    tcpdump

    # connect
    #blueman
    networkmanager

    # nixos
    nix-index
    nix-prefetch-git
    nix-prefetch-scripts
    mkpasswd

  ];

  environment.variables = {
    EDITOR = "vim";
  };

  #hardware.bluetooth.enable = true;
  # Add extra config for modern Bluetooth headsets.
  #hardware.bluetooth.extraConfig = "
  #  [General]
  #  Enable=Source,Sink,Media,Socket
  #";

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    # Enable Bluetooth sound.
    package = pkgs.pulseaudioFull;
  #  extraModules = [ pkgs.pulseaudio-modules-bt ];
  #  configFile = pkgs.writeText "default.pa" ''
  #    load-module module-bluetooth-policy
  #    load-module module-bluetooth-discover
  #    ## module fails to load with 
  #    ##   module-bluez5-device.c: Failed to get device path from module arguments
  #    ##   module.c: Failed to load module "module-bluez5-device" (argument: ""): initialization failed.
  #    # load-module module-bluez5-device
  #    # load-module module-bluez5-discover
  #  '';
  };

  programs.ssh = {
    startAgent = true;
  };

  virtualisation.docker.enable = true;

  nixpkgs.config.pulseaudio = true;

  services = {

    logind.extraConfig = "HandlePowerKey=suspend";

    printing.enable = true;

    xserver = {
      enable = true;
      dpi = 192;
      libinput.enable = true;
      layout = "us";

      displayManager.sddm = {
        enable = true;
        enableHidpi = true;
        #defaultUser = "tim";
        #autoLogin = false;
        setupScript = ''
          
        '';
      };

      desktopManager = {
        plasma5.enable = true;
        #default = "xfce";
        #xterm.enable = false;
        #xfce = {
        #  enable = true;
        #  noDesktop = true;
        #  enableXfwm = false;
        #};
        wallpaper.mode = "fill";
      };

      desktopManager.session = [{
        name = "home-manager";
        start = ''
          ${pkgs.stdenv.shell} $HOME/.xsession-hm &
          waitPID=$!
          startkde
        '';
      }];
    };
  };

  security.sudo.configFile = ''
    %wheel ALL = (ALL) ALL
    %wheel ALL = (root) NOPASSWD: /run/current-system/sw/bin/nethogs
  '';

  security.sudo.extraConfig = "Defaults timestamp_timeout=60";
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
