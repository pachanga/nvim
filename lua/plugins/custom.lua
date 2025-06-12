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
              ["ctrl-q"] = "select-all+accept",
          },
      },
    }
  },

  {
    "gbprod/yanky.nvim",
    enabled = false
  },

  {
    "echasnovski/mini.pairs",
    enabled = false
  },

  {
    "echasnovski/mini.surround",
     event = "VeryLazy",
  },

  {
    "echasnovski/mini.move",
    version = "*",
    opts = {
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "<C-h>",
        right = "<C-l>",
        down = "<C-j>",
        up = "<C-k>",

        -- Move current line in Normal mode
        line_left = "<C-h>",
        line_right = "<C-l>",
        line_down = "<C-j>",
        line_up = "<C-k>",
      },
    },
  },

  {
    "gbprod/yanky.nvim",
    enabled = false,  
    keys = {
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

  { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },

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

    end,
  },

  {
    "akinsho/bufferline.nvim",
    enabled = false,
    event = "VeryLazy",
    --keys = {
    --  { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
    --  { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    --},
    opts = function(_, opts)
      -- Set default options first
      opts.options = {
        mode = "buffers",
        --numbers = "ordinal",
        always_show_bufferline = true,
        color_icons = false,
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
      }

      ---- Add the catppuccin highlights
      --if (vim.g.colors_name or ""):find("catppuccin") then
      --  opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
      --end

      return opts
    end,
  },

  --{
  --  "cbochs/grapple.nvim",
  --  opts = {
  --      scope = "git", -- also try out "git_branch"
  --  },
  --  event = { "BufReadPost", "BufNewFile" },
  --  cmd = "Grapple",
  --  keys = {
  --      { "<leader>m", "<cmd>Grapple toggle<cr>", desc = "Grapple toggle tag" },
  --      { "<leader>M", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window" },
  --      --{ "<leader>n", "<cmd>Grapple cycle_tags next<cr>", desc = "Grapple cycle next tag" },
  --      --{ "<leader>p", "<cmd>Grapple cycle_tags prev<cr>", desc = "Grapple cycle previous tag" },
  --  },
  --},

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
    -- stylua: ignore
    keys = {
      -- let's add convenience mapping
      { "<leader>,", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    },
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
            autoinsert = false,
          }
        }
      }
    },
    cmdline = {
      enabled = false,
    },
  },

  {
    'folke/noice.nvim',
    opts = {
      routes = {
        filter = {
          any = {
              { cond = function(_) return true end }
          },
        },
      }
    }
  },

  {
    'mg979/vim-visual-multi',
    branch = "master"
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
    opts = { ensure_installed = {
        "goimports",
        "gofumpt",
        "gomodifytags",
        "impl",
        "delve",

        "phpcs",
        "php-cs-fixer",

        "omnisharp",
        --"csharp-language-server",
        "csharpier",
        "netcoredbg",

        "tflint",
      } },
  },

  -- doesn't support mason2 yet?
  --{
  --  "zapling/mason-lock.nvim",
  --  init = function()
  --    require("mason-lock").setup({
  --        lockfile_path = vim.fn.stdpath("config") .. "/mason-lock.json" -- (default)
  --    })
  --  end
  --},

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

  --{
  --  "ray-x/navigator.lua",
  --  dependencies = {
  --      {"hrsh7th/nvim-cmp"}, {"nvim-treesitter/nvim-treesitter"},
  --      {"ray-x/guihua.lua", run = "cd lua/fzy && make"}, {
  --          "ray-x/go.nvim",
  --          event = {"CmdlineEnter"},
  --          ft = {"go", "gomod"},
  --          build = ':lua require("go.install").update_all_sync()'
  --      }, {
  --          "ray-x/lsp_signature.nvim", -- Show function signature when you type
  --          event = "VeryLazy",
  --          config = function() require("lsp_signature").setup() end
  --      }
  --  },
  --},
}
