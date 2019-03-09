# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./user-configuration.nix
      "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/release-18.09.tar.gz}/nixos"
    ];

  boot = {
    kernelPackages = pkgs.linuxPackages_4_19;
    cleanTmpDir = true;
    #plymouth.enable = true;
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
    consoleUseXkbConfig = true;
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  };

  time.timeZone = "Europe/Berlin";

  environment.systemPackages = with pkgs; [
     blueman
     gitAndTools.gitFull
     networkmanager
     nix-index
     nix-prefetch-git nix-prefetch-scripts
     wget
     vim
     unzip                  # Archives
     tree                   # Show file hierarchies
     fzf                    # Fuzzy file finder
     ripgrep                # Fast grep replacement
     bat                    # Cat replacement
     fd                     # Find replacement
     gotop                  # Top replacement
     ncdu                   # Fancy disk usage analyzer
  ];

  environment.variables = {
    EDITOR = "vim";
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  programs.ssh = {
    startAgent = true;
  };

  services = {

    logind.extraConfig = "HandlePowerKey=suspend";

    printing.enable = true;

    xserver = {
      enable = true;
      dpi = 180;
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
  system.stateVersion = "18.09"; # Did you read the comment?
}
