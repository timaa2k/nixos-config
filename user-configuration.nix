{ pkgs, ... }:

{
  users.mutableUsers = false;

  users.extraUsers.tim = {
    isNormalUser = true;
    home = "/home/tim";
    description = "Tim Weidner";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    hashedPassword = "$6$4RfV2SAFDtKDsBVz$FJnXrf1hiEUMxzKKfw.p0uwNtdXNcVoTDAGB0pkt1/p2Im9c232FzoSPP/NrsQqTMNPoTCjvF6JQsx6IuKCSb0";
  };

  nixpkgs.config.chromium = {
    proprietaryCodecs = true;
    #enablePepperFlash = true;

  };

  fonts.fonts = with pkgs; [
    corefonts
    dejavu_fonts
    dina-font
    fira-code
    fira-code-symbols
    font-awesome-ttf
    inconsolata
    liberation_ttf
    mplus-outline-fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    powerline-fonts
    proggyfonts
    roboto
    source-code-pro
    source-sans-pro
    source-serif-pro
    terminus_font
    ubuntu_font_family
  ];
  fonts.fontconfig.ultimate.enable = true;

  fonts.fontconfig.defaultFonts = {
    monospace = [
      "DejaVu Sans Mono"
    ];
    sansSerif = [
      "DejaVu Sans"
    ];
    serif = [
      "DejaVu Serif"
    ];
  };

  fonts.fontconfig.dpi = 168;

  home-manager.users.tim = {

    #fonts.fontconfig.enableProfileFonts = true;
    home.language = {};
    home.keyboard = {
      options = [ "caps:ctrl_modifier" ];
    };

    home.packages = with pkgs; [

      # cmdline
      exa
      fzf
      gitAndTools.gitFull
      gnumake
      gnupg
      go
      jq
      ranger
      tmux
      udisks
      unzip
      xorg.xdpyinfo
      youtube-dl

      # python
      python36Full
      python3Packages.python-language-server
      python3Packages.pyls-mypy
      python3Packages.pyls-isort
      python3Packages.pyls-black

      # graphical
      alacritty
      chromium
      dmenu
      feh
      flameshot
      networkmanagerapplet
      pavucontrol
      slack
      vlc
      zathura

      # i3
      i3-gaps
      jsoncpp
      wirelesstools
    ];

    programs.chromium = {
      enable = true;
      extensions = [
        "gighmmpiobklfepjocnamgkkbiglidom" # AdBlock
        "mlomiejdfkolichcflejclcbmpeaniij" # Ghostery
        "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
        "kgjfgplpablkjnlkjmjdecgdpfankdle" # Zoom Scheduler
        "fdpohaocaechififmbbbbbknoalclacl" # Full Page Screen Capture
      ];
    };

    programs.man.enable = true;

    programs.go = {
      enable = true;
      goPath = "Code/go";
      goBin  = "Code/go/bin";
    };

    programs.git = {
      package = pkgs.gitAndTools.gitFull;
      enable = true;
      userName  = "Tim Weidner";
      userEmail = "timaa2k@gmail.com";
      aliases = {
        authors = "shortlog -s -n";
      };
    };

    programs.neovim = {
      enable = true;
      withPython3 = true;
      vimAlias = true;
      viAlias = true;
      configure = {
        packages.myVimPackage = with pkgs.vimPlugins; {
          start = [
            vim-startify
            vim-sensible
            vim-fugitive
            vim-gitgutter
            vim-surround
            vim-colorschemes
            lightline-vim
            vim-multiple-cursors
            vim-eunuch
            vim-polyglot
            fzf-vim
            LanguageClient-neovim
            deoplete-go
            deoplete-jedi
          ];
        };
        customRC = ''
          let g:LanguageClient_serverCommands = {
          \ 'python': ['pyls']
          \ }
          nnoremap <F5> :call LanguageClient_contextMenu()<CR>
          nnoremap <silent> gh :call LanguageClient_textDocument_hover()<CR>
          nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
          nnoremap <silent> gr :call LanguageClient_textDocument_references()<CR>
          nnoremap <silent> gs :call LanguageClient_textDocument_documentSymbol()<CR>
          nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
          nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<CR>

          syntax on
          color smyck
          highlight Pmenu guibg=white guifg=black gui=bold
          highlight Comment gui=bold
          highlight Normal gui=none
          highlight NonText guibg=none

          set mouse=a

          set splitbelow
          set splitright

          set termguicolors

          filetype plugin indent on
          set autoindent
          set tabstop=4
          set softtabstop=4
          set shiftwidth=4
          set expandtab
          set smarttab

          set incsearch ignorecase smartcase hlsearch
          set ruler laststatus=2 showcmd showmode
          set nolist
          set wrap breakindent
          set encoding=utf-8
          set number
          set title

          let mapleader = "\<Space>"
          nmap <leader>t :NERDTreeToggle<CR>
          nmap <leader>b :TagbarToggle<CR>
          nmap <leader>r :so ~/.config/nvim/init.vim<CR>
          nmap <leader>s <C-w>s<C-w>j:terminal<CR>
          nmap <leader>vs <C-w>v<C-w>l:terminal<CR>
          nmap <leader>f :Files<CR>
          nmap <silent> <leader><leader> :noh<CR>
          nmap <Tab> :bnext<CR>
          nmap <S-Tab> :bprevious<CR>

          nnoremap <leader>- <c-W>s
          nnoremap <leader>/ <c-W>v

          " Disable .swp already exists warning
          set shortmess+=A
        '';
      };
    };

    programs.command-not-found.enable = true;

    services = {
      blueman-applet.enable = true;
      dunst.enable = true;
      flameshot.enable = true;
      network-manager-applet.enable = true;
      udiskie.enable = true;
    };

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      defaultCacheTtl = 1800;
    };

    services.gnome-keyring = {
enable = true;
      components = [ "pkcs11" "secrets" "ssh" ];
    };

    services.polybar = {
      package = pkgs.polybar.override {
        i3GapsSupport = true;
        pulseSupport = true;
        #iwSupport = true;
        githubSupport = true;
      };
      enable = true;
      config = {
        "bar/top" = {
          font-0 = "monospace:size=11;2";
          font-1 = "Roboto:size=11:weight=bold;2";
          font-2 = "Noto Sans:size=11;1";
          font-4 = "Font Awesome 5 Free:pixelsize=10;0";
          monitor = "\${env:MONITOR:eDP-1}";
          width = "100%";
          height = "3%";
          radius = 0;
          module-margin = 4;
          modules-left = "i3";
          modules-center = "";
          modules-right = "wlan cpu memory battery date";
          tray-position = "right";
          tray-maxsize = 16;
          tray-padding = 2;
          #tray-background = "#aa2222";
        };
        "module/i3" = {
          type = "internal/i3";
          scroll-up = "i3wm-wsnext";
          scroll-down = "i3wm-wsprev";
        };
        "module/wlan" = {
          type = "internal/wlan";
          interval = 3;
          interface = "wlp3s0";
          label-connected = "WLAN%essid%%";
        };
        "module/cpu" = {
          type = "internal/cpu";
          interval = 2;
          label = "CPU %percentage:2%%";
        };
        "module/memory" = {
          type = "internal/memory";
          interval = 2;
          label = "RAM %percentage_used:2%%";
        };
        "module/battery" = {
          type = "internal/battery";
          battery = "BAT0";
          adapter = "AC0";
          full-at = 100;
        };
        "module/date" = {
          type = "internal/date";
          interval = 5;
          date = "%d.%m.%y";
          time = "%H:%M:%S";
          label = "%date%  %time%";
        };
      };
      script = "polybar top &";
    };

    home.sessionVariables = {
      BROWSER = "chromium";
      EDITOR = "vim";
      TERMINAL = "alacritty";
      WINIT_HIDPI_FACTOR = "1";
    };

    xsession = {
      enable = true;
      windowManager.i3 = rec {
        package = pkgs.i3-gaps;
        enable = true;
        config = {
          startup = [
            {
              command      = "systemctl --user restart polybar";
              always       = true;
              notification = false;
            }
          ];
          bars = [];
          gaps = {
            inner        = null;
            outer        = null;
            smartGaps    = false;
            smartBorders = "on";
          };
          modifier = "Mod1";
          keycodebindings = let mod = config.modifier; in {
            "${mod}+49"          = "workspace 0";
            "${mod}+Shift+49"    = "move container to workspace 0";
          };
          keybindings = let mod = config.modifier; in {
            "${mod}+Shift+r"     = "restart";
            "${mod}+Shift+c"     = "reload";
            "${mod}+Shift+q"     = "kill";

            "${mod}+Shift+plus"  = "gaps inner all plus 5";
            "${mod}+Shift+minus" = "gaps inner all minus 5";

            "${mod}+r"           = "mode resize";
            "${mod}+x"           = "mode machine";

            "${mod}+Return"      = "exec i3-sensible-terminal";
            "${mod}+d"           = "exec i3-sensible-terminal -e ranger";
            "${mod}+p"           = "exec ${pkgs.dmenu}/bin/dmenu_run -i -l 20";
            "${mod}+b"           = "exec ${pkgs.chromium}/bin/chromium --incognito --force-device-scale-factor=1.5";
            "${mod}+s"           = "exec ${pkgs.pavucontrol}/bin/pavucontrol &";
            "${mod}+Print"       = "exec ${pkgs.flameshot}/bin/flameshot gui";

            "${mod}+h"           = "focus left";
            "${mod}+j"           = "focus down";
            "${mod}+k"           = "focus up";
            "${mod}+l"           = "focus right";

            "${mod}+Left"        = "focus left";
            "${mod}+Down"        = "focus down";
            "${mod}+Up"          = "focus up";
            "${mod}+Right"       = "focus right";

            "${mod}+Shift+h"     = "move left";
            "${mod}+Shift+j"     = "move down";
            "${mod}+Shift+k"     = "move up";
            "${mod}+Shift+l"     = "move right";

            "${mod}+Shift+Left"  = "move left";
            "${mod}+Shift+Down"  = "move down";
            "${mod}+Shift+Up"    = "move up";
            "${mod}+Shift+Right" = "move right";

            "${mod}+g"           = "split h";
            "${mod}+v"           = "split v";
            "${mod}+f"           = "fullscreen";

            "${mod}+Shift+f"     = "floating toggle";

            "${mod}+1"           = "workspace 1";
            "${mod}+2"           = "workspace 2";
            "${mod}+3"           = "workspace 3";
            "${mod}+4"           = "workspace 4";
            "${mod}+5"           = "workspace 5";
            "${mod}+6"           = "workspace 6";
            "${mod}+7"           = "workspace 7";
            "${mod}+8"           = "workspace 8";
            "${mod}+9"           = "workspace 9";

            "${mod}+Shift+1"     = "move container to workspace 1";
            "${mod}+Shift+2"     = "move container to workspace 2";
            "${mod}+Shift+3"     = "move container to workspace 3";
            "${mod}+Shift+4"     = "move container to workspace 4";
            "${mod}+Shift+5"     = "move container to workspace 5";
            "${mod}+Shift+6"     = "move container to workspace 6";
            "${mod}+Shift+7"     = "move container to workspace 7";
            "${mod}+Shift+8"     = "move container to workspace 8";
            "${mod}+Shift+9"     = "move coltainer to workspace 9";
          };
          modes = {
            resize = {
              "h"      = "resize shrink width 10 px or 10 ppt";
              "j"      = "resize grow height 10 px or 10 ppt";
              "k"      = "resize shrink height 10 px or 10 ppt";
              "l"      = "resize grow width 10 px or 10 ppt";
              "Return" = "mode default";
              "Escape" = "mode default";
            };
            machine = {
              "e"      = "exec i3-msg exit";
              "s"      = "exec systemctl suspend";
              "h"      = "exec systemctl hibernate";
              "r"      = "exec systemctl reboot";
              "p"      = "exec systemctl poweroff";
              "Return" = "mode default";
              "Escape" = "mode default";
            };
          };
          colors = {
            background    = "#ffffff";
            focused = {
              border      = "#4c7899";
              background  = "#285577";
              text        = "#ffffff";
              indicator   = "#2e9ef4";
              childBorder = "#285577";
            };
            focusedInactive = {
              border      = "#333333";
              background  = "#5f676a";
              text        = "#ffffff";
              indicator   = "#484e50";
              childBorder = "#5f676a";
            };
            unfocused = {
              border      = "#333333";
              background  = "#222222";
              text        = "#888888";
              indicator   = "#292d2e";
              childBorder = "#222222";
            };
            urgent = {
              border      = "#2f343a";
              background  = "#900000";
              text        = "#ffffff";
              indicator   = "#900000";
              childBorder = "#900000";
            };
            placeholder = {
              border      = "#000000";
              background  = "#0c0c0c";
              text        = "#ffffff";
              indicator   = "#000000";
              childBorder = "#0c0c0c";
            };
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

    xresources.properties = {
      "Xft*dpi" = 192;
    };
    #xresources.extraConfig = {};

    xdg = {
      enable = true;

      #configFile."chromium-flags.conf" = {
      #  text = ''
      #    --force-device-scale-factor=1.1
      #  '';
      #};

      configFile."alacritty/alacritty.yml" = {
        text = ''
          env:
            TERM: xterm-256color

          window:
            dimensions:
              columns: 0
              lines: 0
            padding:
              x: 2
              y: 2
            decorations: full

          scrolling:
            history: 100000
            multiplier: 3
            faux_multiplier: 3
            auto_scroll: false
            
          tabspaces: 4

          font:
            normal:
              family: monospace
              style: Regular
            bold:
              family: monospace
              style: Bold
            italic:
              family: monospace
              style: Italic
            size: 18.0
            offset:
              x: 0
              y: 0
            glyph_offset:
              x: 0
              y: 0

          render_timer: false
          draw_bold_text_with_bright_colors: true

          colors:
            primary:
              background: '0x000000'
              foreground: '0xeaeaea'
              #dim_foreground: '0x9a9a9a'
              #bright_foreground: '0xffffff'
            cursor:
              text:    '0x000000'
              cursor:  '0xffffff'
            normal:
              black:   '0x000000'
              red:     '0xd54e53'
              green:   '0xb9ca4a'
              yellow:  '0xe6c547'
              blue:    '0x7aa6da'
              magenta: '0xc397d8'
              cyan:    '0x70c0ba'
              white:   '0xffffff'
            bright:
              black:   '0x666666'
              red:     '0xff3334'
              green:   '0x9ec400'
              yellow:  '0xe7c547'
              blue:    '0x7aa6da'
              magenta: '0xb77ee0'
              cyan:    '0x54ced6'
              white:   '0xffffff'
            dim:
              black:   '0x333333'
              red:     '0xf2777a'
              green:   '0x99cc99'
              yellow:  '0xffcc66'
              blue:    '0x6699cc'
              magenta: '0xcc99cc'
              cyan:    '0x66cccc'
              white:   '0xdddddd'
            #indexed_colors:
            #  - { index: 16, color: '0x000000' }

          visual_bell:
            animation: EaseOutExpo
            duration: 0

          background_opacity: 1.0

          mouse_bindings:
            - { mouse: Middle, action: PasteSelection }

          mouse:
            double_click: { threshold: 300 }
            triple_click: { threshold: 300 }

          selection:
            semantic_escape_chars: ",│`|:\"' ()[]{}<>"
            save_to_clipboard: false

          dynamic_title: true

          mouse.hide_when_typing: false

          cursor.style: Block
          cursor.unfocused_hollow: true

          live_config_reload: true

          #shell:
            #program: /bin/bash
            #args:
            #  - --login

          key_bindings:
            - { key: V,        mods: Control|Shift,    action: Paste               }
            - { key: C,        mods: Control|Shift,    action: Copy                }
            - { key: Paste,                   action: Paste                        }
            - { key: Copy,                    action: Copy                         }
            - { key: Q,        mods: Command, action: Quit                         }
            - { key: W,        mods: Command, action: Quit                         }
            - { key: Insert,   mods: Shift,   action: PasteSelection               }
            - { key: Key0,     mods: Control, action: ResetFontSize                }
            - { key: Equals,   mods: Control, action: IncreaseFontSize             }
            - { key: Subtract, mods: Control, action: DecreaseFontSize             }
            - { key: Home,                    chars: "\x1bOH",   mode: AppCursor   }
            - { key: Home,                    chars: "\x1b[H",   mode: ~AppCursor  }
            - { key: End,                     chars: "\x1bOF",   mode: AppCursor   }
            - { key: End,                     chars: "\x1b[F",   mode: ~AppCursor  }
            - { key: PageUp,   mods: Shift,   chars: "\x1b[5;2~"                   }
            - { key: PageUp,   mods: Control, chars: "\x1b[5;5~"                   }
            - { key: PageUp,                  chars: "\x1b[5~"                     }
            - { key: PageDown, mods: Shift,   chars: "\x1b[6;2~"                   }
            - { key: PageDown, mods: Control, chars: "\x1b[6;5~"                   }
            - { key: PageDown,                chars: "\x1b[6~"                     }
            - { key: Tab,      mods: Shift,   chars: "\x1b[Z"                      }
            - { key: Back,                    chars: "\x7f"                        }
            - { key: Back,     mods: Alt,     chars: "\x1b\x7f"                    }
            - { key: Insert,                  chars: "\x1b[2~"                     }
            - { key: Delete,                  chars: "\x1b[3~"                     }
            - { key: Left,     mods: Shift,   chars: "\x1b[1;2D"                   }
            - { key: Left,     mods: Control, chars: "\x1b[1;5D"                   }
            - { key: Left,     mods: Alt,     chars: "\x1b[1;3D"                   }
            - { key: Left,                    chars: "\x1b[D",   mode: ~AppCursor  }
            - { key: Left,                    chars: "\x1bOD",   mode: AppCursor   }
            - { key: Right,    mods: Shift,   chars: "\x1b[1;2C"                   }
            - { key: Right,    mods: Control, chars: "\x1b[1;5C"                   }
            - { key: Right,    mods: Alt,     chars: "\x1b[1;3C"                   }
            - { key: Right,                   chars: "\x1b[C",   mode: ~AppCursor  }
            - { key: Right,                   chars: "\x1bOC",   mode: AppCursor   }
            - { key: Up,       mods: Shift,   chars: "\x1b[1;2A"                   }
            - { key: Up,       mods: Control, chars: "\x1b[1;5A"                   }
            - { key: Up,       mods: Alt,     chars: "\x1b[1;3A"                   }
            - { key: Up,                      chars: "\x1b[A",   mode: ~AppCursor  }
            - { key: Up,                      chars: "\x1bOA",   mode: AppCursor   }
            - { key: Down,     mods: Shift,   chars: "\x1b[1;2B"                   }
            - { key: Down,     mods: Control, chars: "\x1b[1;5B"                   }
            - { key: Down,     mods: Alt,     chars: "\x1b[1;3B"                   }
            - { key: Down,                    chars: "\x1b[B",   mode: ~AppCursor  }
            - { key: Down,                    chars: "\x1bOB",   mode: AppCursor   }
            - { key: F1,                      chars: "\x1bOP"                      }
            - { key: F2,                      chars: "\x1bOQ"                      }
            - { key: F3,                      chars: "\x1bOR"                      }
            - { key: F4,                      chars: "\x1bOS"                      }
            - { key: F5,                      chars: "\x1b[15~"                    }
            - { key: F6,                      chars: "\x1b[17~"                    }
            - { key: F7,                      chars: "\x1b[18~"                    }
            - { key: F8,                      chars: "\x1b[19~"                    }
            - { key: F9,                      chars: "\x1b[20~"                    }
            - { key: F10,                     chars: "\x1b[21~"                    }
            - { key: F11,                     chars: "\x1b[23~"                    }
            - { key: F12,                     chars: "\x1b[24~"                    }
            - { key: F1,       mods: Shift,   chars: "\x1b[1;2P"                   }
            - { key: F2,       mods: Shift,   chars: "\x1b[1;2Q"                   }
            - { key: F3,       mods: Shift,   chars: "\x1b[1;2R"                   }
            - { key: F4,       mods: Shift,   chars: "\x1b[1;2S"                   }
            - { key: F5,       mods: Shift,   chars: "\x1b[15;2~"                  }
            - { key: F6,       mods: Shift,   chars: "\x1b[17;2~"                  }
            - { key: F7,       mods: Shift,   chars: "\x1b[18;2~"                  }
            - { key: F8,       mods: Shift,   chars: "\x1b[19;2~"                  }
            - { key: F9,       mods: Shift,   chars: "\x1b[20;2~"                  }
            - { key: F10,      mods: Shift,   chars: "\x1b[21;2~"                  }
            - { key: F11,      mods: Shift,   chars: "\x1b[23;2~"                  }
            - { key: F12,      mods: Shift,   chars: "\x1b[24;2~"                  }
            - { key: F1,       mods: Control, chars: "\x1b[1;5P"                   }
            - { key: F2,       mods: Control, chars: "\x1b[1;5Q"                   }
            - { key: F3,       mods: Control, chars: "\x1b[1;5R"                   }
            - { key: F4,       mods: Control, chars: "\x1b[1;5S"                   }
            - { key: F5,       mods: Control, chars: "\x1b[15;5~"                  }
            - { key: F6,       mods: Control, chars: "\x1b[17;5~"                  }
            - { key: F7,       mods: Control, chars: "\x1b[18;5~"                  }
            - { key: F8,       mods: Control, chars: "\x1b[19;5~"                  }
            - { key: F9,       mods: Control, chars: "\x1b[20;5~"                  }
            - { key: F10,      mods: Control, chars: "\x1b[21;5~"                  }
            - { key: F11,      mods: Control, chars: "\x1b[23;5~"                  }
            - { key: F12,      mods: Control, chars: "\x1b[24;5~"                  }
            - { key: F1,       mods: Alt,     chars: "\x1b[1;6P"                   }
            - { key: F2,       mods: Alt,     chars: "\x1b[1;6Q"                   }
            - { key: F3,       mods: Alt,     chars: "\x1b[1;6R"                   }
            - { key: F4,       mods: Alt,     chars: "\x1b[1;6S"                   }
            - { key: F5,       mods: Alt,     chars: "\x1b[15;6~"                  }
            - { key: F6,       mods: Alt,     chars: "\x1b[17;6~"                  }
            - { key: F7,       mods: Alt,     chars: "\x1b[18;6~"                  }
            - { key: F8,       mods: Alt,     chars: "\x1b[19;6~"                  }
            - { key: F9,       mods: Alt,     chars: "\x1b[20;6~"                  }
            - { key: F10,      mods: Alt,     chars: "\x1b[21;6~"                  }
            - { key: F11,      mods: Alt,     chars: "\x1b[23;6~"                  }
            - { key: F12,      mods: Alt,     chars: "\x1b[24;6~"                  }
            - { key: F1,       mods: Super,   chars: "\x1b[1;3P"                   }
            - { key: F2,       mods: Super,   chars: "\x1b[1;3Q"                   }
            - { key: F3,       mods: Super,   chars: "\x1b[1;3R"                   }
            - { key: F4,       mods: Super,   chars: "\x1b[1;3S"                   }
            - { key: F5,       mods: Super,   chars: "\x1b[15;3~"                  }
            - { key: F6,       mods: Super,   chars: "\x1b[17;3~"                  }
            - { key: F7,       mods: Super,   chars: "\x1b[18;3~"                  }
            - { key: F8,       mods: Super,   chars: "\x1b[19;3~"                  }
            - { key: F9,       mods: Super,   chars: "\x1b[20;3~"                  }
            - { key: F10,      mods: Super,   chars: "\x1b[21;3~"                  }
            - { key: F11,      mods: Super,   chars: "\x1b[23;3~"                  }
            - { key: F12,      mods: Super,   chars: "\x1b[24;3~"                  }
        '';
      };
    };
  };
}

