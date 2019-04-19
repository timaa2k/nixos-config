# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./user-configuration.nix
      "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/release-19.03.tar.gz}/nixos"
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
    fd
    gitAndTools.gitFull
    gitAndTools.hub
    lsof
    pciutils
    psmisc
    ripgrep
    tree
    usbutils
    utillinux
    vim
    wget

    # monitor 
    atop
    ethtool
    htop
    iotop
    ncdu
    sysstat
    tcpdump

    # connect
    blueman
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
        #defaultUser = "tim";
        #autoLogin = false;
      };

      desktopManager.plasma5 = {
        enable = true;
      };

      desktopManager.session = [{
        name = "home-manager";
        start = ''
          ${pkgs.stdenv.shell} $HOME/.xsession-hm &
          waitPID=$!
        '';
      }];
    };
  };

  security.sudo.extraConfig = "Defaults timestamp_timeout=60";
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
