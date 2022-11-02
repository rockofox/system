{ pkgs, lib, ... }:
let
  loadPlugin = plugin: ''
    set rtp^=${plugin}
    set rtp+=${plugin}/after
  '';
  loadPlugins = ps: lib.pipe ps [
    (builtins.map loadPlugin)
    (builtins.concatStringsSep "\n")
  ];
  extra-plugins = import ./plugins.nix { inherit pkgs lib; };
  plugins = with pkgs.vimPlugins; [
    # use Treesitter for many languages
    (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))

    # autocompletion
    cmp-buffer
    cmp-cmdline
    cmp-nvim-lsp
    cmp-omni
    cmp-path
    cmp-treesitter
    cmp_luasnip
    copilot-vim
    nvim-cmp

    # LSP
    cmp-nvim-lsp
    fzf-lsp-nvim
    lsp_extensions-nvim
    lsp_signature-nvim
    lspkind-nvim
    luasnip
    nvim-lspconfig

    # other useful things :^)
    barbar-nvim
    direnv-vim
    editorconfig-nvim
    fidget-nvim
    fzf-vim
    fzfWrapper
    gitsigns-nvim
    impatient-nvim
    incsearch-vim
    lualine-nvim
    nvim-autopairs
    nvim-base16
    nvim-surround
    nvim-tree-lua
    nvim-web-devicons
    plenary-nvim
    rust-tools-nvim
    toggleterm-nvim
    trouble-nvim
  ];
  

in {
  home.packages = with pkgs; [
    # Copilot doesn't work with Node.js 18 yet
    # TODO: Find a solution that donesn't pollute global namespace
    nodejs-16_x
  ];
  programs.neovim = {
    enable = true;
    # package = nixos-unstable.neovim-unwrapped;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;

    extraConfig = ''
      " Workaround for broken handling of packpath by vim8/neovim for ftplugins -- see https://github.com/NixOS/nixpkgs/issues/39364#issuecomment-425536054 for more info
      filetype off | syn off
      ${loadPlugins plugins}
    filetype indent plugin on | syn on
      ${builtins.readFile ./init.vim}
    lua << EOF
      ${builtins.readFile ./init.lua}
    EOF'';
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
