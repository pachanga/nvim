-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
return {
  {
    "LazyVim/LazyVim",
    opts = {
      --colorscheme = "catppuccin",
      colorscheme = "tokyonight",
    },
  },

  --{ "catppuccin/nvim", name = "catppuccin", priority = 1000, opts = {
  --  flavour = "mocha",
  --} },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "moon",
      on_highlights = function(hl, c)
      end,
    },
  },

  {
    "ibhagwan/fzf-lua",
    opts = {
      keymap = {
          fzf = {
              -- to fix list
              ["ctrl-q"] = "select-all+accept",
          },
      },
    }
  },

  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-w>h", "<cmd>:TmuxNavigateLeft<cr>" },
      { "<c-w>j", "<cmd>:TmuxNavigateDown<cr>" },
      { "<c-w>k", "<cmd>:TmuxNavigateUp<cr>" },
      { "<c-w>l", "<cmd>:TmuxNavigateRight<cr>" },
      { "<c-w>\\", "<cmd>:TmuxNavigatePrevious<cr>" },
    },
  },

  {
    "echasnovski/mini.pairs",
  },

  {
    "echasnovski/mini.surround",
     event = "VeryLazy",
  },

  {
    "echasnovski/mini.move",
    version = "*",
    opts = {
      --mappings = {
      --  -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
      --  left = "<C-h>",
      --  right = "<C-l>",
      --  down = "<C-j>",
      --  up = "<C-k>",

      --  -- Move current line in Normal mode
      --  line_left = "<C-h>",
      --  line_right = "<C-l>",
      --  line_down = "<C-j>",
      --  line_up = "<C-k>",
      --},
    },
  },

  {
    "gbprod/yanky.nvim",
    keys = {
      { "<leader>p", false },
      {
        "<leader>y",
        function()
          if LazyVim.pick.picker.name == "telescope" then
            require("telescope").extensions.yank_history.yank_history({})
          else
            vim.cmd([[YankyRingHistory]])
          end
        end,
        mode = { "n", "x" },
        desc = "Open Yank History",
      }
    }
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "c_sharp",
        "go",
        "gomod",
        "gowork",
        "gosum",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "php",
        "twig",
        "printf",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "hcl",
        "terraform",
      },
    },
  },

  --{ "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },

  {
    'ludovicchabant/vim-gutentags',
    lazy = false,
    config = function()
      vim.g.gutentags_file_list_command = 'ag -U -g ""'
    end
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)

      opts.sections.lualine_c[4] = { "filename", path = 3 }
      --opts.sections.lualine_c = {function() return vim.fn.getcwd() end}

    end,
  },

  {
    "akinsho/bufferline.nvim",
    enabled = false,
    event = "VeryLazy",
  },

  {
    "hrsh7th/nvim-cmp",
    enabled = false
  },

  {
    "cbochs/grapple.nvim",
    opts = {
        --scope = "git", -- also try out "git_branch"
        --scope = "global",
        scope = "static",
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = "Grapple",
    keys = {
        { "<leader>m", "<cmd>Grapple toggle<cr>", desc = "Grapple toggle tag" },
        { "<leader>M", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window" },
        --{ "<leader>n", "<cmd>Grapple cycle_tags next<cr>", desc = "Grapple cycle next tag" },
        --{ "<leader>p", "<cmd>Grapple cycle_tags prev<cr>", desc = "Grapple cycle previous tag" },
    },
  },

  --{
  --  "leath-dub/snipe.nvim",
  --  keys = {
  --    {"<F3>", function () require("snipe").open_buffer_menu() end, desc = "Open Snipe buffer menu"}
  --  },
  --  opts = {
  --    ui = { position = 'center', },
  --    --preselect_current = true,
  --    --sort = "last",
  --  }
  --},

  {
    'b0o/incline.nvim',
    config = function()
      require('incline').setup{
        render = function(props)
          --local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':~')
          local modified = vim.bo[props.buf].modified
          return {
            ' ',
            { filename, gui = 'bold' },
            modified and { ' *', guifg = '#888888', gui = 'bold' } or '',
            ' ',
            guibg = '#44406e',
            guifg = '#eeeeee',
          }
        end
      }
    end,
    -- Optional: Lazy load Incline
    event = 'VeryLazy',
  },

  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        hidden = true, -- for hidden files
        ignored = true, -- for .gitignore files
        sources = {
          files = { ignored = true, hidden = true },
          buffers = { ignored = true, hidden = true },
          explorer = { ignored = true, hidden = true, auto_close = true },
          grep = { ignored = true, hidden = true },
          grep_word = { ignored = true, hidden = true },
          grep_buffers = { ignored = true, hidden = true },
        }
      },
    },
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    opts = {},
    keys = {},
  },

  {
    'Lokaltog/vim-easymotion',
    config = function()
      vim.g.EasyMotion_do_mapping = 0 -- Disable default mappings
      vim.g.EasyMotion_smartcase = 1  -- Turn on case sensitive feature

      -- Bi-directional find motion
      -- Jump to anywhere you want with minimal keystrokes, with just one key binding.
      -- `s{char}{label}`
      vim.keymap.set('n', '<leader>,', '<Plug>(easymotion-s)')
    end
  },

  {
    'saghen/blink.cmp',
     opts = {
       keymap = {
         --preset = "enter",
         --["<C-y>"] = { "select_and_accept" },
         --preset = 'super-tab',
         preset = 'default',
         ["<Tab>"] = { "select_next", "fallback" },
         ["<S-Tab>"] = { "select_prev", "fallback" },
       },
       completion = {
         list = {
           selection = {
             preselect = false,
             auto_insert = true,
           }
         }
       },
       --sources = {
       --  default = { 'lsp', 'path', 'snippets', 'buffer'},
       --}
    },
    cmdline = {
      enabled = false,
    },
  },

  {
    'folke/noice.nvim',
    opts = {
      lsp ={
        progress = {
          enabled = true
        }
      },
      routes = {
        filter = {
          any = {
              { cond = function(_) return true end }
          },
        },
      }
    }
  },

  --{
  --  'mg979/vim-visual-multi',
  --  branch = "master"
  --},

   {
    "seblyng/roslyn.nvim",
    ft = "cs",
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
        -- your configuration comes here; leave empty for default settings
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      terraformls = {},
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
            },
          },
        },
        phpactor = {
          enabled = true
        },
        --intelephense = {
        --  enabled = true
        --},

        --omnisharp = {
        --  cmd = { "dotnet", "/Users/ps/.local/share/nvim/mason/packages/omnisharp/OmniSharp.dll", "-lsp", "--hostPID", tostring(vim.fn.getpid())},
        --  root_dir = require("lspconfig").util.root_pattern("unity/unity.sln", "*.csproj", "*.sln"),
        --  handlers = {
        --    ["textDocument/definition"] = function(...)
        --      return require("omnisharp_extended").handler(...)
        --    end,
        --  },
        --  enable_roslyn_analyzers = true,
        --  organize_imports_on_format = true,
        --  enable_import_completion = true,
        --},

      },

      setup = {
        gopls = function(_, opts)
          -- workaround for gopls not supporting semanticTokensProvider
          -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
          LazyVim.lsp.on_attach(function(client, _)
            if not client.server_capabilities.semanticTokensProvider then
              local semantic = client.config.capabilities.textDocument.semanticTokens
              client.server_capabilities.semanticTokensProvider = {
                full = true,
                legend = {
                  tokenTypes = semantic.tokenTypes,
                  tokenModifiers = semantic.tokenModifiers,
                },
                range = true,
              }
            end
          end, "gopls")
          -- end workaround
        end,
      }
    },
  },

  {
    "mason-org/mason.nvim",
    lazy = true,
    config = function()
      require('mason').setup({
        registries = {
          'github:Crashdummyy/mason-registry',
          'github:mason-org/mason-registry',
        },
        ensure_installed = {
          "goimports",
          "gofumpt",
          "gomodifytags",
          "impl",
          "delve",

          "phpcs",
          "php-cs-fixer",

          --"omnisharp",
          --"csharp-language-server",
          "csharpier",
          "netcoredbg",

          "tflint",
        }
    })
    end
  },

  {
    "nvimtools/none-ls.nvim",
    optional = true,
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = { ensure_installed = { "gomodifytags", "impl" } },
      },
    },
    opts = function(_, opts)
      local nls = require("null-ls")

      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.code_actions.gomodifytags,
        nls.builtins.code_actions.impl,
        nls.builtins.formatting.goimports,
        nls.builtins.formatting.gofumpt,
      })

      table.insert(opts.sources, nls.builtins.formatting.phpcsfixer)
      table.insert(opts.sources, nls.builtins.diagnostics.phpcs)

      table.insert(opts.sources, nls.builtins.formatting.csharpier)
    end,
  },

  {
    "stevearc/conform.nvim",
    lazy = true,
    opts = {
      formatters_by_ft = {
        go = {
          "goimports",
          "gofumpt",
        },
        lua = {
          "stylua"
        },
        php = {
          "php_cs_fixer",
        },
        cs = {
          "csharpier",
        }
      },

      formatters = {
        csharpier = {
          command = "dotnet-csharpier",
          args = { "--write-stdout" },
        },
      },
    },
  },

  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = { ensure_installed = { "delve" } },
      },
      {
        "leoluz/nvim-dap-go",
        opts = {},
      },
    },
  },

  {
    "Issafalcon/neotest-dotnet",
  },

  {
    "Pocco81/auto-save.nvim",
    lazy = false,
    opts = {
      debounce_delay = 500,
      execution_message = {
        message = function()
          return ""
        end,
      },
    },
    keys = {
      { "<leader>uv", "<cmd>ASToggle<CR>", desc = "Toggle autosave" },
    },
  },

  {
    'preservim/vimux',
    keys = {
      { "<leader>vp", "<cmd>VimuxPromptCommand<CR>", desc = "Vimux Prompt Command" },
      { "<leader>vl", "<cmd>VimuxRunLastCommand<CR>", desc = "Vimux Run Last Command" },
      { "<leader>vi", "<cmd>VimuxInspectRunner<CR>", desc = "Vimux Inspect Runner" },
      { "<leader>vq", "<cmd>VimuxCloseRunner<CR>", desc = "Vimux Close Runner" },
    }
  },

  {
    "Exafunction/codeium.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        require("codeium").setup({
           enable_cmp_source = false,
           virtual_text = {
              enabled = true,

              key_bindings = {
                --accept = false -- handled by nvim-cmp / blink.cmp
                accept = "<F1>",
                next = "<M-]>",
                prev = "<M-[>",
              },

              ---- These are the defaults
              ---- Set to true if you never want completions to be shown automatically.
              --manual = false,
              ---- A mapping of filetype to true or false, to enable virtual text.
              --filetypes = {},
              ---- Whether to enable virtual text of not for filetypes not specifically listed above.
              --default_filetype_enabled = true,
              ---- How long to wait (in ms) before requesting completions after typing stops.
              --idle_delay = 75,
              ---- Priority of the virtual text. This usually ensures that the completions appear on top of
              ---- other plugins that also add virtual text, such as LSP inlay hints, but can be modified if
              ---- desired.
              --virtual_text_priority = 65535,
              ---- Set to false to disable all key bindings for managing completions.
              --map_keys = true,
              ---- The key to press when hitting the accept keybinding but no completion is showing.
              ---- Defaults to \t normally or <c-n> when a popup is showing. 
              --accept_fallback = nil,
              ---- Key bindings for managing completions in virtual text mode.
              --key_bindings = {
              --    -- Accept the current completion.
              --    accept = "<Tab>",
              --    -- Accept the next word.
              --    accept_word = false,
              --    -- Accept the next line.
              --    accept_line = false,
              --    -- Clear the virtual text.
              --    clear = false,
              --    -- Cycle to the next completion.
              --    next = "<M-]>",
              --    -- Cycle to the previous completion.
              --    prev = "<M-[>",
              --}
          }
        })
    end
  },
}
