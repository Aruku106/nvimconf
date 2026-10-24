return {
  {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = "qwen2.5-coder:32b",
              },
              num_ctx = {
                default = 16384, -- 16k context is a good start for your 64GB RAM
              },
            },
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "ollama",
          roles = {
            llm = "CodeCompanion Agent", -- Optional: identifies the AI as an agent
          },
          slash_commands = {
            ["file"] = { callback = "strategies.chat.slash_commands.file" },
            ["buffer"] = { callback = "strategies.chat.slash_commands.buffer" },
          },
        },
        agent = {
          adapter = "ollama",
        },
      },
      display = {
        chat = {
          show_settings = true, -- Shows model info in the chat buffer
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "ThePrimeagen/vim-be-good",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "cpp",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
        "yaml",
        "gdscript", -- Essential for Godot
        "godot_resource",
        "gdshader",
      },
      highlight = {
        enable = true,
      },
      auto_install = {
        enable = true,
      },
   	},
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "williamboman/mason.nvim",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup()

        local mason_registry = require("mason-registry")
        local codelldb = mason_registry.get_package("codelldb")
        local codelldb_path = codelldb:get_install_path() .. "/extension/adapter/codelldb"
        local liblldb_path = codelldb:get_install_path() .. "/extension/lldb/lib/liblldb.so"

        dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = codelldb_path,
                args = { "--liblldb", liblldb_path, "--port", "${port}" },
            },
        }

        dap.configurations.cpp = {
            {
                name = "Launch MVScriptCompiler",
                type = "codelldb",
                request = "launch",
                program = "${workspaceFolder}/build/MVScriptCompiler",
                cwd = "${workspaceFolder}/build",
                args = { "test.vms" },
                stopOnEntry = false,
            },
        }

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end
    end,
  },
}
