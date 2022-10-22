{ pkgs, lib, ... }:
let
  vim-plugins = import ./plugins.nix { inherit pkgs lib; };
in {
  home.packages = with pkgs; [
    tree-sitter
    nodePackages.vim-language-server
    nodePackages.bash-language-server
    rnix-lsp
    nodePackages.vscode-json-languageserver-bin
    nodePackages.vscode-css-languageserver-bin
    kotlin-language-server
    nodePackages.vscode-html-languageserver-bin
    yaml-language-server
    sumneko-lua-language-server
    # haskell-language-server
  ];
   programs.neovim = {
    enable = true;
    # package = nixos-unstable.neovim-unwrapped;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      csv-vim
      copilot-vim
      onedark-vim
      vim-surround  # fix config
      vim-repeat
      # vim-speeddating  # makes statusline buggy??
      vim-commentary
      vim-unimpaired
      vim-sleuth  # adjusts shiftwidth and expandtab based on the current file
      # vim-startify
      vim-multiple-cursors
      gundo-vim
      vim-easy-align
      vim-table-mode
      editorconfig-vim
      vim-markdown
      ansible-vim
      vim-nix
      robotframework-vim
      # vimspector
      vim-plugins.nvim-base16  # the one packaged in nixpkgs is different
      popup-nvim
      plenary-nvim
      telescope-nvim
      telescope-symbols-nvim
      # telescope-media-files  # doesn't support wayland yet
      nvim-colorizer-lua
      nvim-treesitter
      nvim-lspconfig
      lsp_extensions-nvim
      # completion-nvim
      cmp-nvim-lsp
      nvim-cmp
      lspkind-nvim
      gitsigns-nvim
      neogit
      diffview-nvim
      # bufferline-nvim
      vim-plugins.nvim-cokeline
      nvim-autopairs
      galaxyline-nvim
      vim-closetag
      friendly-snippets
      vim-vsnip
      nvim-tree-lua
      nvim-web-devicons
      vim-devicons
      vim-auto-save
      vim-plugins.neoscroll-nvim
      vim-plugins.zenmode-nvim
      vim-plugins.indent-blankline-nvim  # using my own derivation because the nixpkgs still uses the master branch
      vim-easymotion
      quick-scope
      matchit-zip
      targets-vim
      neoformat
      vim-numbertoggle
      # vim-markdown-composer
      vimwiki
      pkgs.vimwiki-markdown
      vim-python-pep8-indent
      lsp_signature-nvim
      rust-tools-nvim
      vim-plugins.keymap-layer-nvim
      vim-plugins.hydra-nvim
    ];

    extraConfig = "lua << EOF\n" + builtins.readFile ./init.lua + "\nEOF";
  };

}
