return {
  -- Blink.nvim 补全引擎
  {
    "SentoMK/blink.cmp",
    version = "1.*",
    dependencies = {
      "rafamadriz/friendly-snippets", -- 代码片段库
      "hrsh7th/cmp-nvim-lsp"          -- LSP 补全源
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
          "lsp",     -- 来自LSP的语义补全
          "path",    -- 文件路径补全
          "snippets",-- 代码片段
          "buffer"   -- 当前缓冲区补全
        }
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      completion = {
        keyword = { range = "prefix" },
        menu = {
          draw = {
            treesitter = { "lsp" }, -- 使用treesitter高亮
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
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    }
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      -- 根据需要还可加其他 source，如：
      -- 'hrsh7th/cmp-buffer',
      -- 'hrsh7th/cmp-path',
      -- 'L3MON4D3/LuaSnip',
    },
  },  
  -- Mason LSP 配置
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = { "clangd" }, -- 自动安装的LSP
   }
  },

  -- LSP 核心配置
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- 获取LSP能力配置（需先加载cmp-nvim-lsp）
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      capabilities.textDocument.completion.completionItem = {
        snippetSupport = true,
        resolveSupport = {
          properties = { "documentation", "detail", "additionalTextEdits" }
        }
      }

      -- Clangd 配置
      require('lspconfig').clangd.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- 自定义快捷键
          local opts = { buffer = bufnr, silent = true }
          vim.keymap.set('n', '<leader>ch', '<Cmd>ClangdSwitchSourceHeader<CR>', opts)
          vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, opts)
          
          -- 禁用特定客户端的格式化（如果使用其他格式化工具）
          client.server_capabilities.documentFormattingProvider = false
        end,
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=never",
          "--completion-style=detailed",
          "--query-driver=/usr/bin/gcc" -- 指定编译器路径
        },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_dir = require('lspconfig.util').root_pattern(
          'compile_commands.json',
          '.clangd',
          '.git'
        ),
        -- 禁用特定诊断（根据项目需要调整）
        init_options = {
          clangdFileStatus = true,
          usePlaceholders = true,
          completeUnimported = true,
          semanticHighlighting = true
        }
      })
      -- 全局LSP配置（适用于所有语言服务器）
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client.server_capabilities.hoverProvider then
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
          end
        end
      })
    end
  },

   -- 可选：增强诊断显示
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
