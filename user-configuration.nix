{ pkgs, ... }:

{

#sha256 = "0g4d1z96pkdfdxgs5w4bkik3p25g6j322vk9m0l9jqc4412f513g";
#rev = "dd94a849df69fe62fe2cb23a74c2b9330f1189ed";
#url = https://github.com/rycee/home-manager;

  users.mutableUsers = false;

  users.extraUsers.tim = {
    isNormalUser = true;
    home = "/home/tim";
    description = "Tim Weidner";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    hashedPassword = "$6$4RfV2SAFDtKDsBVz$FJnXrf1hiEUMxzKKfw.p0uwNtdXNcVoTDAGB0pkt1/p2Im9c232FzoSPP/NrsQqTMNPoTCjvF6JQsx6IuKCSb0";
  };

  home-manager.users.tim = {

    home.packages = [
      pkgs.i3
      pkgs.gitAndTools.gitFull
      pkgs.udisks
      pkgs.jq
      pkgs.ranger
      pkgs.alacritty
      pkgs.tmux
      pkgs.zathura
      pkgs.gnupg
      pkgs.unzip
      pkgs.youtube-dl
      pkgs.flameshot
    ];

    programs.git = {
      package = pkgs.gitAndTools.gitFull;
      enable = true;
      userName  = "Tim Weidner";
      userEmail = "timaa2k@gmail.com";
    };

    programs.command-not-found.enable = true;

    services.flameshot.enable = true;

    services.udiskie.enable = true;

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      defaultCacheTtl = 1800;
    };

    xsession = {
      enable = true;
      windowManager.i3 = rec {
	enable = true;
	config = {
	  modifier = "Mod1";
	  keybindings = let mod = config.modifier; in {
            "${mod}+Return" = "exec alacritty";
            "${mod}+Print" = "exec flameshot gui";
            "${mod}+enter" = "exec alacritty";
	    "${mod}+Shift+r" = "restart";
	    "${mod}+Shift+q" = "kill";
	    "${mod}+d" = "exec alacritty -e ranger";
	    "${mod}+b" = "exec chromium";
	    "${mod}+h" = "focus left";
	    "${mod}+j" = "focus down";
	    "${mod}+k" = "focus up";
	    "${mod}+l" = "focus right";
	    "${mod}+Left" = "focus left";
	    "${mod}+Down" = "focus down";
	    "${mod}+Up" = "focus up";
	    "${mod}+Right" = "focus right";
	    "${mod}+Shift+h" = "move left";
	    "${mod}+Shift+j" = "move down";
	    "${mod}+Shift+k" = "move up";
	    "${mod}+Shift+l" = "move right";
	    "${mod}+Shift+Left" = "move left";
	    "${mod}+Shift+Down" = "move down";
	    "${mod}+Shift+Up" = "move up";
	    "${mod}+Shift+Right" = "move right";
	    "${mod}+g" = "split h";
	    "${mod}+v" = "split v";
	    "${mod}+f" = "fullscreen";
	    "${mod}+Shift+s" = "layout stacking";
	    "${mod}+Shift+t" = "layout tabbed";
	    "${mod}+Shift+f" = "floating toggle";
	    "${mod}+1" = "workspace 1";
	    "${mod}+2" = "workspace 2";
	    "${mod}+3" = "workspace 3";
	    "${mod}+4" = "workspace 4";
	    "${mod}+5" = "workspace 5";
	    "${mod}+6" = "workspace 6";
	    "${mod}+7" = "workspace 7";
	    "${mod}+8" = "workspace 8";
	    "${mod}+9" = "workspace 9";
	    "${mod}+0" = "workspace 10";
	    "${mod}+Shift+1" = "move container to workspace 1";
	    "${mod}+Shift+2" = "move container to workspace 2";
	    "${mod}+Shift+3" = "move container to workspace 3";
	    "${mod}+Shift+4" = "move container to workspace 4";
	    "${mod}+Shift+5" = "move container to workspace 5";
	    "${mod}+Shift+6" = "move container to workspace 6";
	    "${mod}+Shift+7" = "move container to workspace 7";
	    "${mod}+Shift+8" = "move container to workspace 8";
	    "${mod}+Shift+9" = "move coltainer to workspace 9";
	    "${mod}+Shift+0" = "move container to workspace 10";
	  };
	};
      };
      scriptPath = ".xsession-hm";
      profileExtra =
      ''
	xrdb -merge ~/.extend.Xresources
	bass source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
      '';
    };
  };
}
