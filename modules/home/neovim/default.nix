{ config, pkgs, lib, nix-colors, ... }:
let
  loadPlugin = plugin: ''
    set rtp^=${plugin}
    set rtp+=${plugin}/after
  '';
  loadPlugins = ps:
    lib.pipe ps [ (builtins.map loadPlugin) (builtins.concatStringsSep "\n") ];
  nix-colors-lib = nix-colors.lib-contrib { inherit pkgs; };
  # extra-plugins = import ./plugins.nix { inherit pkgs lib; };
  haskell-tools-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "haskell-tools-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "mrcjkb";
      repo = "haskell-tools.nvim";
      rev = "2c3cbdf386ecb03210b56962db96e601705c5118";
      hash = "sha256-OCF5OOJztvaSYMR81OdBnrVPUsHAwhQh1jpiXf4XcNM=";
    };
  };
  plugins = with pkgs.vimPlugins; [
    # extra-plugins.copilot-lua
    # extra-plugins.copilot-cmp
    copilot-lua
    copilot-cmp
    # cmp-tabnine

    nvim-treesitter.withAllGrammars
    nvim-ts-rainbow2
    nvim-treesitter-textobjects
    nvim-treesitter-refactor

    # kotlin-vim

    # autocompletion
    cmp-buffer
    cmp-cmdline
    cmp-nvim-lsp
    cmp-omni
    cmp-path
    cmp-treesitter
    cmp_luasnip
    nvim-cmp

    # LSP
    cmp-nvim-lsp
    fzf-lsp-nvim
    lsp-inlayhints-nvim
    lsp_extensions-nvim
    lsp_signature-nvim
    lspkind-nvim
    nvim-lspconfig
    luasnip
    nvim-lspconfig
    vim-nix
    haskell-tools-nvim

    # other useful things :^)
    # barbar-nvim
    bufferline-nvim
    comment-nvim
    direnv-vim
    vim-easymotion
    editorconfig-nvim
    fidget-nvim
    fzf-vim
    fzfWrapper
    gitsigns-nvim
    incsearch-vim
    lualine-nvim
    nvim-autopairs
    nvim-base16
    nvim-highlight-colors
    nvim-surround
    # nvim-tree-lua
    oil-nvim
    nvim-web-devicons
    plenary-nvim
    neogit
    rust-tools-nvim
    # tabby-nvim
    telescope-nvim
    toggleterm-nvim
    trouble-nvim
    vim-sleuth
    winbar-nvim
    which-key-nvim
    rose-pine
    nvim-scrollbar
    neotest
    neotest-haskell
    FixCursorHold-nvim
  ];

in {
  home.packages = with pkgs; [
    # Copilot doesn't work with Node.js 18 yet
    # TODO: Find a solution that donesn't pollute global namespace
    nodejs-18_x
    tabnine
    nil
    kotlin-language-server
    nodePackages.typescript-language-server
    nodePackages.vscode-html-languageserver-bin
    nodePackages.vscode-css-languageserver-bin
    haskell-language-server
    haskellPackages.hoogle
  ];
  programs.neovim = {
    enable = true;
    # package = pkgs.neovim-nightly;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    plugins = [{
      plugin =
        nix-colors-lib.vimThemeFromScheme { scheme = config.colorScheme; };
      config = ''
      '';
    }];

    extraConfig = lib.mkBefore ''
        " Workaround for broken handling of packpath by vim8/neovim for ftplugins -- see https://github.com/NixOS/nixpkgs/issues/39364#issuecomment-425536054 for more info
        filetype off | syn off
        ${loadPlugins plugins}
      filetype indent plugin on | syn on
        ${builtins.readFile ./init.vim}
      lua << EOF
        ${builtins.readFile ./init.lua}
      EOF
      " silent! colorscheme default
      " silent! colorscheme nix-${config.colorScheme.slug}
      " silent! colorscheme base16-${config.colorScheme.slug}
      " silent! colorscheme ${config.colorScheme.slug}
      '';
      extraLuaConfig = lib.mkBefore ''
        -- bytecompile lua modules
        vim.loader.enable()

        -- load .exrc, .nvimrc and .nvim.lua local files
        vim.o.exrc = true
      '';
  };

  xdg.configFile = {
    # Lua files in this directory will be available for Lua `require`
    "nvim/lua".source = ./lua;

    # Lua files in this directory will be evaluated on startup
    "nvim/plugin".source = ./plugin;

    # per-language configuration in either Lua or VimL
    "nvim/ftplugin".source = ./ftplugin;

    # initial configuration for GUIs like Neovim-Qt or VimR
    "nvim/ginit.vim".source = ./ginit.vim;
  };
}
