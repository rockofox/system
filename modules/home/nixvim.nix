{ config, pkgs, lib, nix-colors, ... }:
{
  programs.nixvim = {
    enable = true;

    defaultEditor = true;
    extraPlugins = with pkgs; [ vimPlugins.haskell-tools-nvim vimPlugins.vim-horizon ];
    globals.mapleader = " ";
    highlight.ExtraWhitespace.bg = "red";
    keymaps = [
      {
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        key = "<leader>ca";
      }
      {
        action = "<cmd>lua vim.lsp.buf.format()<CR>";
        key = "<leader>cf";
      }
      {
        action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
        key = "gD";
      }
      {
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        key = "gd";
      }
      {
        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
        key = "K";
      }
      {
        action = "<cmd>lua vim.lsp.buf.implementation()<CR>";
        key = "gi";
      }
      {
        action = "<cmd>lua vim.lsp.buf.signature_help()<CR>";
        key = "<C-k>";
      }
      {
        action = "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>";
        key = "<leader>wa";
      }
      {
        action = "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>";
        key = "<leader>wr";
      }
      {
        action = "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>";
        key = "<leader>wl";
      }
      {
        action = "<cmd>lua vim.lsp.buf.type_definition()<CR>";
        key = "<leader>D";
      }
      {
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
        key = "<leader>rn";
      }
      {
        action = "<cmd>lua vim.lsp.buf.references()<CR>";
        key = "gr";
      }
      {
        action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
        key = "[d";
      }
      {
        action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
        key = "]d";
      }
      {
        action = "<cmd>lua vim.diagnostic.setloclist()<CR>";
        key = "<leader>q";
      }
      {
        action = "<cmd>Oil<CR>";
        key = "-";
      }
      {
        action = "<cmd>Telescope find_files<CR>";
        key = "<leader>ff";
      }
      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>fg";
      }
      {
        action = "<cmd>Telescope buffers<CR>";
        key = "<leader>fb";
      }
      {
        action = "<cmd>Telescope help_tags<CR>";
        key = "<leader>fh";
      }
      {
        action = "<cmd>Oil<CR>";
        key = "-";
      }
      {
        action = "<cmd>Telescope find_files<CR>";
        key = "<leader>ff";
      }
      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>fg";
      }
      {
        action = "<cmd>Telescope buffers<CR>";
        key = "<leader>fb";
      }
      {
        action = "<cmd>Telescope help_tags<CR>";
        key = "<leader>fh";
      }
      {
        action = "<cmd>Neogit<CR>";
        key = "<leader>gg";
      }
    ];
    opts = {
      updatetime = 100;
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      swapfile = false;
      undofile = true;
      incsearch = true;
      inccommand = "split";
      ignorecase = true;
      smartcase = true;
      signcolumn = "yes:1";
    };
    diagnostic.settings = {
      virtual_text = true;
    };
    plugins = {
      # obsidian.enable = true;
      helm.enable = true;
      render-markdown.enable = true;
      copilot-lua = {
        enable = true;
        settings.suggestion.enabled = true;
      };
      avante.enable = true;
      avante.settings = {
        provider = "copilot";
      };
      wakatime.enable = true;
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            css = [ "prettier" ];
            html = [ "prettier" ];
            json = [ "prettier" ];
            lua = [ "stylua" ];
            markdown = [ "prettier" ];
            nix = [ "alejandra" ];
            python = [ "black" ];
            ruby = [ "rubyfmt" ];
            terraform = [ "tofu_fmt" ];
            tf = [ "tofu_fmt" ];
            yaml = [ "yamlfmt" ];
          };
        };
      };
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          mapping = {
            "<C-d>" = # Lua
              "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = # Lua
              "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = # Lua
              "cmp.mapping.complete()";
            "<C-e>" = # Lua
              "cmp.mapping.close()";
            "<Tab>" = # Lua
              "cmp.mapping(cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}), {'i', 's'})";
            "<S-Tab>" = # Lua
              "cmp.mapping(cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}), {'i', 's'})";
            "<CR>" = # Lua
              "cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace })";
          };
          sources = [
            {
              name = "nvim_lsp";
              priority = 1000;
            }
            {
              name = "nvim_lsp_signature_help";
              priority = 1000;
            }
            {
              name = "treesitter";
              priority = 850;
            }
            {
              name = "buffer";
              priority = 500;
            }
          ];
        };
      };
      dressing.enable = true;
      fugitive.enable = true;
      git-conflict.enable = true;
      neogit.enable = true;
      lualine.enable = true;
      luasnip.enable = true;
      bufferline.enable = true;
      illuminate.enable = true;
      nvim-autopairs.enable = true;
      sleuth.enable = true;
      trouble.enable = true;
      lsp = {
        enable = true;
        servers = {
          ts_ls.enable = true; # TS/JS
          cssls.enable = true; # CSS
          bashls.enable = true;
          jsonls.enable = true;
          lua_ls = {
            enable = true;
            settings.telemetry.enable = false;
          };
          marksman.enable = true;
          nil_ls = {
            enable = true;
            settings = {
              formatting.command = [ "nixpkgs-fmt" ];
            };
          };
          pylsp = {
            enable = true;
            settings.plugins = {
              black.enabled = true;
              flake8.enabled = false;
              isort.enabled = true;
              jedi.enabled = false;
              mccabe.enabled = false;
              pycodestyle.enabled = false;
              pydocstyle.enabled = true;
              pyflakes.enabled = false;
              pylint.enabled = true;
              rope.enabled = false;
              yapf.enabled = false;
            };
          };
          # yamlls.enable = true;
          # Handled by haskell-tools
          # hls = {
          #   enable = true;
          #   installGhc = true;
          # };
        };
      };
      none-ls.sources.formatting.black.enable = true;
      oil.enable = true;
      telescope.enable = true;
      treesitter = {
        enable = true;
        settings = {
          auto_install = true;
          highlight.enable = true;
        };
      };
      web-devicons.enable = true;
      which-key = {
        enable = true;
        settings.preset = "helix";
      };
      lspkind = {
        enable = true;
        symbolMap = {
          # Copilot = "";
        };
        extraOptions = {
          maxwidth = 50;
          ellipsis_char = "...";
        };
      };
    };
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraConfigVim = ''
      syntax on
      filetype on
      filetype plugin on
      filetype indent on
      " command W w
      command Wd w !diff % -

      " Keep selection after indent
      vnoremap < <gv
      vnoremap > >gv

      " map <leader>Ss :mksession! ~/vim_session <cr> " Quick write session
      " map <leader>Sl :source ~/vim_session <cr>     " And load session

      map <F2> :mksession! ~/vim_session <cr> " Quick write session
      map <F3> :source ~/vim_session <cr>     " And load session
      augroup kitty_mp
          autocmd!
          au VimLeave * :silent !kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=4
          au VimEnter * :silent !kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=0
      augroup END

      onoremap <expr> *  v:count ? '*'  : '<esc>*g``'.v:operator.'gn'

      nnoremap <C-y> <C-W>h
      nnoremap <C-n> <C-W>j
      nnoremap <C-i> <C-W>k
      nnoremap <C-o> <C-W>l
      nnoremap <S-Enter> o<Esc>
      nnoremap \ <C-o>
      nnoremap \| <C-i>

      set shellcmdflag=-ic
      set shortmess+=W

      if has('nvim')
        augroup vimrc_term
          autocmd!
          autocmd WinEnter term://* nohlsearch
          autocmd WinEnter term://* startinsert

          autocmd TermOpen * tnoremap <buffer> <C-y> <C-\><C-n><C-w>h
          autocmd TermOpen * tnoremap <buffer> <C-n> <C-\><C-n><C-w>j
          autocmd TermOpen * tnoremap <buffer> <C-i> <C-\><C-n><C-w>k
          autocmd TermOpen * tnoremap <buffer> <C-o> <C-\><C-n><C-w>l
          autocmd TermOpen * tnoremap <buffer> <Esc> <C-\><C-n>
        augroup END
      endif

      let g:cursorhold_updatetime = 100
      au BufNewFile,BufRead *.ejs set filetype=html
      set clipboard=unnamed
    '';
    extraConfigLua = ''
      local ht = require('haskell-tools')
      local bufnr = vim.api.nvim_get_current_buf()
      local opts = { noremap = true, silent = true, buffer = bufnr, }
      -- haskell-language-server relies heavily on codeLenses,
      -- so auto-refresh (see advanced configuration) is enabled by default
      vim.keymap.set('n', '<space>cl', vim.lsp.codelens.run, opts)
      -- Hoogle search for the type signature of the definition under the cursor
      vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)
      -- Evaluate all code snippets
      vim.keymap.set('n', '<space>ea', ht.lsp.buf_eval_all, opts)
      -- Toggle a GHCi repl for the current package
      vim.keymap.set('n', '<leader>rr', ht.repl.toggle, opts)
      -- Toggle a GHCi repl for the current buffer
      vim.keymap.set('n', '<leader>rf', function()
        ht.repl.toggle(vim.api.nvim_buf_get_name(0))
      end, opts)
      vim.keymap.set('n', '<leader>rq', ht.repl.quit, opts)
    '';
  };
  stylix.targets.nixvim.enable = true;
}
