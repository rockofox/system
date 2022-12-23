{ config, pkgs, lib, nix-colors, ... }:
let
  loadPlugin = plugin: ''
    set rtp^=${plugin}
    set rtp+=${plugin}/after
  '';
  loadPlugins = ps: lib.pipe ps [
    (builtins.map loadPlugin)
    (builtins.concatStringsSep "\n")
  ];
  nix-colors-lib = nix-colors.lib-contrib { inherit pkgs; };
  extra-plugins = import ./plugins.nix { inherit pkgs lib; };
  plugins = with pkgs.vimPlugins; [
    # extra-plugins.copilot-lua
    # extra-plugins.copilot-cmp
    cmp-tabnine

    # use Treesitter for many languages
    (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
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
    lsp_extensions-nvim
    lsp_signature-nvim
    lspkind-nvim
    luasnip
    nvim-lspconfig

    # other useful things :^)
    barbar-nvim
    comment-nvim
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
    nvim-highlight-colors
    nvim-surround
    nvim-tree-lua
    nvim-web-devicons
    plenary-nvim
    rust-tools-nvim
    toggleterm-nvim
    trouble-nvim
    vim-sleuth
  ];
  

in {
  home.packages = with pkgs; [
    # Copilot doesn't work with Node.js 18 yet
    # TODO: Find a solution that donesn't pollute global namespace
    nodejs-16_x
    tabnine
  ];
  programs.neovim = {
    enable = true;
    # package = pkgs.neovim-nightly;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    plugins = [    {
      plugin = nix-colors-lib.vimThemeFromScheme { scheme = config.colorScheme; };
      config = "colorscheme nix-${config.colorScheme.slug}";
    }
];

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
