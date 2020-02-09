{ lib, pkgs, ... }:

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
    liberation_ttf
    material-design-icons
    mplus-outline-fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    powerline-fonts
    proggyfonts
    roboto
    siji
    source-code-pro
    source-sans-pro
    source-serif-pro
    terminus_font
    ubuntu_font_family
  ];

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

  fonts.fontconfig.dpi = 192;

  environment.etc."inputrc".text = lib.mkForce (
    builtins.readFile <nixpkgs/nixos/modules/programs/bash/inputrc>
    + ''
      set editing-mode vi
      "\e[5~": history-search-backward
      "\e[6~": history-search-forward
    ''
  );

  home-manager.users.tim = {

    #fonts.fontconfig.enableProfileFonts = true;
    home.language = {};
    home.keyboard = {
      options = [ "caps:ctrl_modifier" ];
    };

    home.packages = with pkgs; [

      # cmdline
      cmake
      delve
      docker-compose
      exa
      fzf
      gcc
      gdrive
      gitAndTools.gitFull
      gitAndTools.pre-commit
      gnumake
      gnupg
      godef
      go-tools
      gparted
      hfsprogs
      jq
      kind
      kubectl
      libnotify
      minikube
      ranger
      ruby
      shellcheck
      tig
      tmate
      tmux
      udisks
      unzip
      xorg.xdpyinfo
      xorg.xfontsel
      youtube-dl

      # python
      python37Full
      python3Packages.python-language-server
      python3Packages.pyls-mypy
      python3Packages.pyls-isort
      python3Packages.pyls-black
      python3Packages.flake8
      mypy

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

    programs.bash = {
      enable = true;
      historySize = 100000;
      historyFile = "$HOME/.bash_history";
      historyFileSize = 1000000;
      historyControl = [ "erasedups" "ignorespace" ];
      historyIgnore = [ "cd" "exit" ];
      sessionVariables = {};
      shellAliases = {
        ".." = "cd ..";
        "ls" = "exa -HFgmB --grid --group-directories-first --time-style=long-iso --git";
        "ll" = "ls -l";
        "la" = "ls -a";
        "wd" = "j";
        "git-delete-merged" = ''
          git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
        '';
      };
      enableAutojump = true;
      profileExtra = "";
      bashrcExtra = "";
      initExtra = "";
    };

    programs.fzf = {
      enable = true;
      defaultOptions = [];
    };

    programs.chromium = {
      enable = true;
      extensions = [
        "gighmmpiobklfepjocnamgkkbiglidom" # AdBlock
        "mlomiejdfkolichcflejclcbmpeaniij" # Ghostery
        "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
        "kgjfgplpablkjnlkjmjdecgdpfankdle" # Zoom Scheduler
        "fdpohaocaechififmbbbbbknoalclacl" # Full Page Screen Capture
        "fhbjgbiflinjbdggehcddcbncdddomop" # Postman
        "bcjindcccaagfpapjjmafapmmgkkhgoa" # JSON Formatter
      ];
    };

    programs.man.enable = true;

    programs.go = {
      package = pkgs.go_1_12;
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
            vim-sensible
            vim-signify
            vim-surround
            vim-colorschemes
            vim-css-color
            vim-commentary
            lightline-vim
            #vim-airline
            fzf-vim
            vim-polyglot
            echodoc-vim
            vim-fugitive
            vim-multiple-cursors
            vim-autoformat
            vim-go
            #LanguageClient-neovim
            jedi-vim
            #deoplete-jedi
            ale
            ncm2
            ncm2-bufword
            ncm2-jedi
            #ncm2-path
            #ncm2-tmux
          ];
        };
        customRC = ''
          syntax on
          color smyck
          highlight Pmenu guibg=white guifg=black gui=bold
          highlight Comment gui=bold
          highlight Normal gui=none
          highlight NonText guibg=none

          set mouse=a
          set wrapscan
          set smartcase

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

          " Change leader key from "\" to ";"
          let mapleader=";"

          " Shortcut to edit THIS file: (e)dit (c)onfiguration
          nnoremap <silent> <leader>ec :e $MYVIMRC<CR>

          " Shortcut to source (reload) THIS file: (s)ource (c)onfig
          nnoremap <silent> <leader>sc :source $MYVIMRC<CR>

          " toggle line wrap
          nnoremap <silent> <leader>w :set wrap! wrap?<CR>

          " toggle buffer (switch between current and last buffer)
          nnoremap <silent> <leader>bb <C-^>

          " go to next buffer
          nnoremap <silent> <leader>bn :bn<CR>
          nnoremap <C-l> :bn<CR>

          " go to previous buffer
          nnoremap <silent> <leader>bp :bp<CR>
          " https://github.com/neovim/neovim/issues/2048
          nnoremap <C-h> :bp<CR>

          " close buffer
          nnoremap <silent> <leader>bd :bd<CR>

          " kill buffer
          nnoremap <silent> <leader>bk :bd!<CR>

          " list buffers
          nnoremap <silent> <leader>bl :ls<CR>
          " list and select buffer
          nnoremap <silent> <leader>bg :ls<CR>:buffer<Space>

          " horizontal split with new buffer
          nnoremap <silent> <leader>bh :new<CR>

          " vertical split with new buffer
          nnoremap <silent> <leader>bv :vnew<CR>
                    
          " improved keyboard navigation
          nnoremap <C-h> <C-w>h
          nnoremap <C-j> <C-w>j
          nnoremap <C-k> <C-w>k
          nnoremap <C-l> <C-w>l

          " Disable .swp already exists warning
          set shortmess+=A


          " Markdown

          au FileType markdown setlocal spell


          " Programming languages

          " Always draw the signcolumn.
          set signcolumn=yes

          " Display function signatures in echo area
          set cmdheight=2
          let g:echodoc#enable_at_startup = 1
          let g:echodoc#type = 'signature'


          " Python

          autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

          " Automatically start language servers.
          let g:LanguageClient_autoStart = 1
          let g:LanguageClient_signColumnAlwaysOn = 1
          " let g:LanguageClient_loggingLevel = 'DEBUG'

          let g:LanguageClient_serverCommands = {
          \ 'python': ['pyls']
          \ }

          function SetLSPShortcuts()
            nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
            nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
            nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
            nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
            nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
            nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
            nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
            nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
            nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
            nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
 
          endfunction()

          augroup LSP
            autocmd!
            autocmd FileType python call SetLSPShortcuts()
          augroup END

          autocmd BufEnter * call ncm2#enable_for_buffer()

          " :help Ncm2PopupOpen for more information
          set completeopt=noinsert,menuone,noselect

          " Make it fast
          let ncm2#complete_delay = 60
          let ncm2#popup_delay = 60
          let ncm2#complete_length = [[1, 1]]
          " Use new fuzzy based matches
          let g:ncm2#matcher = 'substrfuzzy'

          set pumheight=5

		  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
		  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
		  inoremap <silent> <expr> <CR> (pumvisible() && empty(v:completed_item)) ?  "\<c-y>\<cr>" : "\<CR>"

          " ale options
          let g:ale_echo_cursor = '1'

          let g:ale_python_flake8_options = '--ignore=E129,E501,E302,E265,E241,E305,E402,W503'
          let g:ale_python_pylint_options = '-j 0 --max-line-length=79'
          let g:ale_list_window_size = 4
          let g:ale_sign_column_always = 0
          let g:ale_open_list = 0
          let g:ale_keep_list_window_open = '0'
          let g:ale_lint_on_enter = '0'
          let g:ale_lint_on_text_changed = 'never'
          let g:ale_lint_on_save = '1'

          let g:ale_sign_error = 'E'
          let g:ale_sign_warning = 'W'
          let g:ale_echo_msg_error_str = 'E'
          let g:ale_echo_msg_warning_str = 'W'

          let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
          let g:ale_linters = {'python': ['flake8', 'mypy', 'pydocstyle', 'pyls']}
          let g:ale_fixers = {'python': ['remove_trailing_lines', 'isort', 'yapf']}
          "let g:airline#extensions#ale#enabled = 1

          let g:jedi#auto_initialization = 1
          let g:jedi#completions_enabled = 0
          let g:jedi#auto_vim_configuration = 0
          let g:jedi#smart_auto_mappings = 0
          let g:jedi#popup_on_dot = 0
          let g:jedi#completions_command = ""
          let g:jedi#show_call_signatures = "1"
          let g:jedi#show_call_signatures_delay = 0
          let g:jedi#use_tabs_not_buffers = 0
          let g:jedi#show_call_signatures_modes = 'i'  " ni = also in normal mode
          let g:jedi#enable_speed_debugging=0

          :au BufEnter * if &buftype == 'terminal' | :startinsert | endif
          :tnoremap <Esc> <C-\><C-n>

          tnoremap <C-w>h <C-\><C-n><C-w>h
          tnoremap <C-w>j <C-\><C-n><C-w>j
          tnoremap <C-w>k <C-\><C-n><C-w>k
          tnoremap <C-w>l <C-\><C-n><C-w>l

          " Golang

          autocmd Filetype go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

          let g:go_def_mode='gopls'
          let g:go_info_mode='gopls'

          let g:go_auto_sameids = 1
          let g:go_fmt_command = "goimports"
          let g:go_goimports_bin = "goimports -tabwidth=4"
          let g:go_auto_type_info = 1

          let g:go_highlight_build_constraints = 1
          let g:go_highlight_extra_types = 1
          let g:go_highlight_fields = 1
          let g:go_highlight_functions = 1
          let g:go_highlight_methods = 1
          let g:go_highlight_operators = 1
          let g:go_highlight_structs = 1
          let g:go_highlight_types = 1
        '';
      };
    };

    programs.command-not-found.enable = true;

    services = {
      #blueman-applet.enable = true;
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
          locale = "en_US.UTF-8";
          monitor = "\${env:MONITOR:eDP-1}";
          monitor-fallback = "eDP-1";
          monitor-strict = false;

          width = "100%";
          height = "2%";
          #offset-x = "1%";
          #offset-y = "1%";
          radius = 0;
          line-size = 1;
          underline-size = 2;
          underline-color = "#f00";

          module-margin = 1;
          fixed-center = true;

          modules-left = "i3 title";
          modules-center = "";
          modules-right = "wifi disk cpu temperature memory battery date";

          # font-N = <fontconfig pattern>:<vertical offset>
          font-0 = "Terminus:pixelsize=22;2";
          font-1 = "Terminus:pixelsize=20;2";
          font-2 = "Hack:size=12;2";
          font-3 = "FontAwesome:pixelsize=18;2";
          font-4 = "Material Design Icons:size=18;2";

          enable-ipc = true;
        };
        "bar/bottom" = {
          bottom = true;
          monitor = "\${env:MONITOR:eDP-1}";

          width = "100%";
          height = "2%";
          #offset-x = "1%";
          #offset-y = "1%";
          radius = 0;
          line-size = 1;
          underline-size = 2;
          underline-color = "#f00";

          tray-position = "right";
          tray-maxsize = 16;
          tray-padding = 2;
          tray-scale = "1.0";
          #tray-background = "#aa2222";

          module-margin = 1;
          modules-left = "";
          modules-center = "";
          modules-right = "pulseaudio keyboard";

          # font-N = <fontconfig pattern>:<vertical offset>
          font-0 = "Terminus:pixelsize=22;2";
          font-1 = "Terminus:pixelsize=20;2";
          font-2 = "Hack:size=12;2";
          font-3 = "FontAwesome:pixelsize=18;2";
          font-4 = "Material Design Icons:size=18;2";

          pseudo-transparency = true;

          enable-ipc = true;
        };
        "module/title" = {
          type = "internal/xwindow";
          format = "<label>";
          #format-background = "#eee";
          format-foreground = "#fff";
          format-underline = "#fff";
          format-padding = 1;
          label = "%title%";
          label-maxlen = 100;
          label-empty = "";
          label-empty-foreground = "#707880";
        };
        "module/i3" = {
          type = "internal/i3";
          scroll-up = "i3wm-wsnext";
          scroll-down = "i3wm-wsprev";
          pin-workspaces = true;
          strip-wsnumbers = true;
          enable-scroll = true;
          wrapping-scroll = true;
          enable-click = true;

          format = "<label-state> <label-mode>";

          # Available tokens:
          #   %name%
          #   %icon%
          #   %index%
          #   %output%
          # Default: %icon%  %name%
          label-focused = "%index%";
          label-focused-foreground = "#ffffff";
          label-focused-background = "#3f3f3f";
          label-focused-underline = "#fba922";
          label-focused-padding = 1;

          label-unfocused = "%index%";
          label-unfocused-padding = 1;
          label-unfocused-underline = "#1db954";

          label-visible = "%index%";
          label-visible-underline = "#555555";
          label-visible-padding = 1;

          label-urgent = "%index%";
          label-urgent-foreground = "#000000";
          label-urgent-background = "#bd2c40";
          label-urgent-padding = 1;

          label-separator = "";
          label-separator-padding = 0;
          label-separator-foreground = "#ffb52a";

          label-mode = "%mode%";
          label-mode-padding = 1;
          label-mode-background = "#e60053";
        };
        "module/wifi" = {
          type = "internal/network";
          interval = 1;
          interface = "wlp3s0";
          ping-interval = 10;

          label-connected = "%{A1:/home/tim/.nix-profile/bin/nm-connection-editor:}%signal%% %essid%%{A}";
          format-connected = "<ramp-signal> <label-connected>";
          format-connected-underline = "#FFFF00";
          label-disconnected = "%{A1:/home/tim/.nix-profile/bin/nm-connection-editor:}disconnected%{A}";
          label-disconnected-foreground = "#66";
          format-disconnected = "<label-disconnected>";
          format-disconnected-underline = "#FF0000";

          ramp-signal-0 = "冷";
          ramp-signal-0-font = 4;
          ramp-signal-1 = "爛";
          ramp-signal-1-font = 4;
          ramp-signal-2 = "嵐";
          ramp-signal-2-font = 4;
          ramp-signal-3 = "襤";
          ramp-signal-3-font = 4;
          ramp-signal-4 = "蠟";
          ramp-signal-4-font = 4;

          animation-packetloss-0 = "浪";
          animation-packetloss-0-font = 4;
          animation-packetloss-0-foreground = "#ffa64c";
          animation-packetloss-1 = "廊";
          animation-packetloss-1-font = 4;
          animation-packetloss-1-foreground = "#ffffff";
          animation-packetloss-framerate = 500;
        };
        "module/cpu" = {
          type = "internal/cpu";
          interval = "0.5";
          label = "%{A1:WINIT_HIDPI_FACTOR=1 /home/tim/.nix-profile/bin/alacritty -e /run/current-system/sw/bin/htop:}CPU%{A}";
          format = "<label> <ramp-coreload>";
          #format-underline = "#ffa500";
          ramp-coreload-0 = "▁";
          ramp-coreload-0-font = 2;
          ramp-coreload-0-foreground = "#aaff77";
          ramp-coreload-1 = "▂";
          ramp-coreload-1-font = 2;
          ramp-coreload-1-foreground = "#aaff77";
          ramp-coreload-2 = "▃";
          ramp-coreload-2-font = 2;
          ramp-coreload-2-foreground = "#aaff77";
          ramp-coreload-3 = "▄";
          ramp-coreload-3-font = 2;
          ramp-coreload-3-foreground = "#aaff77";
          ramp-coreload-4 = "▅";
          ramp-coreload-4-font = 2;
          ramp-coreload-4-foreground = "#fba922";
          ramp-coreload-5 = "▆";
          ramp-coreload-5-font = 2;
          ramp-coreload-5-foreground = "#fba922";
          ramp-coreload-6 = "▇";
          ramp-coreload-6-font = 2;
          ramp-coreload-6-foreground = "#ff5555";
          ramp-coreload-7 = "█";
          ramp-coreload-7-font = 2;
          ramp-coreload-7-foreground = "#ff5555";
        };
        "module/memory" = {
          type = "internal/memory";
          interval = 2;
          format = "<label>";
          label = "RAM %gb_used%";
        };
        "module/disk" = {
          type = "internal/fs";
          mount-0 = "/";
          interval = 10;
          fixed-values = true;
          spacing = 2;
          label-mounted = "%mountpoint% %free%";
          format-mounted = "<label-mounted>";
          format-mounted-underline = "#1245A8";
          label-unmounted = "%mountpoint%: not mounted";
          format-unmounted = "<label-unmounted>";
          label-unmounted-foreground = "#55";
        };
        "module/battery" = {
          type = "internal/battery";
          battery = "BAT0";
          adapter = "ADP1";
          full-at = 100;

          format-charging = "<animation-charging> <label-charging>";
          format-charging-underline = "#00FF00";
          format-discharging = "<ramp-capacity> <label-discharging>";
          format-discharging-underline = "#FF0000";
          format-full = "<ramp-capacity> <label-full>";

          time-format = "%H:%M";
          label-charging = "%percentage%% %time%h";
          label-discharging = "%percentage%% %time%h";

          ramp-capacity-0 = "";
          ramp-capacity-0-foreground = "#f53c3c";
          ramp-capacity-1 = "";
          ramp-capacity-1-foreground = "#ffa900";
          ramp-capacity-2 = "";
          ramp-capacity-2-foreground = "#ddffff";
          ramp-capacity-3 = "";
          ramp-capacity-3-foreground = "#ddffff";
          ramp-capacity-4 = "";
          ramp-capacity-4-foreground = "#ddffff";

          bar-capacity-width = "10";
          bar-capacity-format = "%{+u}%{+o}%fill%%empty%%{-u}%{-o}";
          bar-capacity-fill = "█";
          bar-capacity-fill-foreground = "#ddffff";
          bar-capacity-fill-font = 2;
          bar-capacity-empty = "█";
          bar-capacity-empty-font = 2;
          bar-capacity-empty-foreground = "#44ffff";

          animation-charging-0 = "";
          animation-charging-1 = "";
          animation-charging-2 = "";
          animation-charging-3 = "";
          animation-charging-4 = "";
          animation-charging-framerate = 750;
        };
        "module/pulseaudio" = {
          type = "internal/pulseaudio";
          #sink = "";
          use-ui-max = false;
          interval = 5;

          label-volume = "";
          label-volume-font = 4;
          format-volume = "<label-volume> <bar-volume>";
          #format-volume-underline = "#FF0000";

          label-muted = "";
          label-muted-font = 4;
          format-muted = "<label-muted>";
          #format-muted-underline = "#FF0000";

          bar-volume-width = 8;
          bar-volume-foreground-0 = "#aaff77";
          bar-volume-foreground-1 = "#aaff77";
          bar-volume-foreground-2 = "#fba922";
          bar-volume-foreground-3 = "#ff5555";
          bar-volume-indicator = "%{A1:/home/tim/.nix-profile/bin/pavucontrol:}|%{A}";
          bar-volume-indicator-font = 0;
          bar-volume-indicator-foreground = "#ffffff";
          bar-volume-fill = "%{A1:/home/tim/.nix-profile/bin/pavucontrol:}─%{A}";
          bar-volume-fill-font = 0;
          bar-volume-empty = "%{A1:/home/tim/.nix-profile/bin/pavucontrol:}─%{A}";
          bar-volume-empty-font = 0;
          bar-volume-empty-foreground = "#444444";
        };
        "module/date" = {
          type = "internal/date";
          interval = 5;
          date = "%Y-%m-%d";
          date-alt = "%A, %d %B %Y";
          time = "%H:%M";
          time-alt = "%H:%M:%S";
          label = "%date%  %time%";
          #format-underline = "#0000FF";
        };
        "module/keyboard" = {
          type = "internal/xkeyboard";
          format = "<label-layout> <label-indicator>";
          label-indicator = "%name%";
        };
        "module/temperature" = {
          type = "internal/temperature";
          interval = "0.5";
          thermal-zone = 2;
          hwmon-path = "/sys/devices/platform/coretemp.0/hwmon/hwmon2/temp1_input";
          warn-temperature = 80;
          units = true;
          ramp-0 = "";
          ramp-0-font = 3;
          ramp-1 = "";
          ramp-1-font = 3;
          ramp-2 = "";
          ramp-2-font = 3;
          ramp-3 = "";
          ramp-3-font = 3;
          ramp-4 = "";
          ramp-4-font = 3;
          #ramp-foreground = "#55";
          label = "%temperature-c%";
          format = "<ramp> <label>";
          label-warn = "%temperature-c%";
          format-warn = "<ramp> <label-warn>";
          label-warn-foreground = "#ff0000";
        };
      };
      #script = "polybar top & polybar bottom &";
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
        extraConfig = ''
          floating_minimum_size 500 x 300
          floating_maximum_size 2000 x 1500
          #for_window [class="(?i)chromium" instance="^(?!Navigator$)"] floating enable
          # Plasma settings
          for_window [class="plasmashell"] floating enable
          for_window [title="Desktop — Plasma"] kill, floating enable, border none
          no_focus [class="plasmashell" window_type="notification"]
          no_focus [class="plasmashell" window_type="on_screen_display"]
        '';
        config = {
          workspaceLayout = "default";
          assigns = {};
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
            "${mod}+c"           = "exec ${pkgs.slack}/bin/slack --force-device-scale-factor=1.5";
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
        export GOROOT=$(go env GOROOT)
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
            size: 17
            normal:
              family: Hack
              style: Regular
            bold:
              family: Hack
              style: Bold
            italic:
              family: Hack
              style: Italic
            offset:
              x: 0
              y: 0
            glyph_offset:
              x: 0
              y: 0

          debug.render_timer: false
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

