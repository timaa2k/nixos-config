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

  home-manager.users.tim = {

    home.sessionVariables = {
      BROWSER = "chromium";
      EDITOR = "vim";
      TERM = "xterm-256color";
    };

    home.packages = with pkgs; [
      alacritty
      chromium
      flameshot
      gitAndTools.gitFull
      gnupg
      go
      i3
      jq
      python36Full
      ranger
      tmux
      udisks
      unzip
      youtube-dl
      zathura
      python3Packages.python-language-server
      python3Packages.pyls-mypy
      python3Packages.pyls-isort
      python3Packages.pyls-black
    ];

    programs.git = {
      package = pkgs.gitAndTools.gitFull;
      enable = true;
      userName  = "Tim Weidner";
      userEmail = "timaa2k@gmail.com";
    };

    programs.vim = {
      enable = true;
      plugins = [
        "vim-startify"
        "vim-sensible"
        "vim-fugitive"
        "vim-gitgutter"
        "vim-surround"
        "vim-colorschemes"
        "lightline-vim"
        "vim-multiple-cursors"
        "vim-eunuch"
        "vim-polyglot"
        "fzf-vim"
        "LanguageClient-neovim"
        "deoplete-go"
        "deoplete-jedi"
      ];
      extraConfig = ''
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
        set tabstop=4
        set softtabstop=4
        set shiftwidth=4
        set expandtab
        set smarttab

        autoindent
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
    #home.file.".vimrc".source = fetchGitHub

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
