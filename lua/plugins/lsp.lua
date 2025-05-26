return {
  -- Blink.nvim 补全引擎（你已经配置得很好）
  {
    "SentoMK/blink.cmp",
    version = "1.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "hrsh7th/cmp-nvim-lsp"
    },
    opts = {
      keymap = {
        preset = "enter",
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      sources = {
        default = {
          "lsp", "path", "snippets", "buffer"
        }
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      completion = {
        keyword = { range = "prefix" },
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
        trigger = { show_on_trigger_character = true },
        documentation = {
          auto_show = true,
        },
      },
      signature = { enabled = true },
    }
  },

  -- Mason 包管理器
  {
    "williamboman/mason.nvim",
    config = true
  },

  -- LSP 配置 + Mason 安装
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason-lspconfig").setup({
        ensure_installed = { "clangd" }
      })

      require("mason-lspconfig").setup_handlers({
        -- 默认 handler：应用于所有 LSP
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,
        -- clangd 特殊处理
        ["clangd"] = function()
          require("lspconfig").clangd.setup({
            capabilities = capabilities,
            cmd = {
              "clangd",
              "--background-index",
              "--clang-tidy",
              "--header-insertion=never",
              "--completion-style=detailed",
              "--query-driver=/usr/bin/gcc"
            },
            filetypes = { "c", "cpp", "objc", "objcpp" },
            root_dir = require("lspconfig.util").root_pattern(
              "compile_commands.json", ".clangd", ".git"
            ),
            init_options = {
              clangdFileStatus = true,
              usePlaceholders = true,
              completeUnimported = true,
              semanticHighlighting = true
            },
            on_attach = function(client, bufnr)
              local opts = { buffer = bufnr, silent = true }
              vim.keymap.set("n", "<leader>ch", "<Cmd>ClangdSwitchSourceHeader<CR>", opts)
              vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, opts)
              client.server_capabilities.documentFormattingProvider = false
            end
          })
        end
      })
    end
  },

  -- nvim-cmp 补全核心（必须搭配 blink.cmp 的 source）
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
  },

  -- 全局 LSP hover 快捷键
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client.server_capabilities.hoverProvider then
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf })
          end
        end
      })
    end
  },

  -- 可选：诊断增强
  {
    "folke/trouble.nvim",
    opts = {
      use_diagnostic_signs = true
    },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" }
    }
  }
}

