{ config, pkgs, lib, nix-colors, ... }:
let
  nix-colors-lib = nix-colors.lib-contrib { inherit pkgs; };
  # extra-plugins = import ./plugins.nix { inherit pkgs lib; };
  muren-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "muren-nvim";
    src = pkgs.fetchFromGitHub {
      repo = "muren.nvim";
      owner = "AckslD";
      rev = "818c09097dba1322b2ca099e35f7471feccfef93";
      hash = "sha256-KDXytsyvUQVZoKdr6ieoUE3e0v5NT2gf3M1d15aYVFs=";
    };
  };
in {
  home.packages = with pkgs; [
    # Copilot doesn't work with Node.js 18 yet
    # TODO: Find a solution that donesn't pollute global namespace
    nodejs-18_x
    tabnine
    nil
    kotlin-language-server
    pyright
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    # haskell-language-server
    haskellPackages.hoogle
  ];
  programs.neovim = {
    enable = true;
    # package = pkgs.neovim-nightly;
    # package = pkgs.neovim-unwrapped;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    plugins = with pkgs.vimPlugins;
      [
        catppuccin-nvim
        neovim-ayu
        vim-wakatime

        # extra-plugins.copilot-lua
        # extra-plugins.copilot-cmp
        copilot-lua
        # copilot-cmp

        # cmp-tabnine

        nvim-treesitter.withAllGrammars
        nvim-treesitter-textobjects
        nvim-treesitter-refactor
        muren-nvim
        rainbow-delimiters-nvim
        markdown-preview-nvim

        elixir-tools-nvim

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
        lsp_lines-nvim
        nvim-lspconfig
        luasnip
        vim-nix
        haskell-tools-nvim

        # other useful things :^)
        # barbar-nvim
        bufferline-nvim
        vim-haskellConcealPlus
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
        base16-nvim
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
        nvim-hlslens
        neotest
        neotest-haskell
        FixCursorHold-nvim
      ] ++ [{
        plugin =
          nix-colors-lib.vimThemeFromScheme { scheme = config.colorScheme; };
        config = "";
      }];

    extraConfig = lib.mkBefore ''
        ${builtins.readFile ./init.vim}
      lua << EOF
        ${builtins.readFile ./init.lua}
      EOF
      silent! colorscheme default
      silent! colorscheme nix-${config.colorScheme.slug}
      silent! colorscheme base16-${config.colorScheme.slug}
      silent! colorscheme ${config.colorScheme.slug}
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
