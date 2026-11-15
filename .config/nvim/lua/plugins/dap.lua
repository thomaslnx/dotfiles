return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      -- Toggles a breakpoint on the current line (adds it if is) --
      { "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "Breakpoint" },

      -- Start the debug session, or resume execution until the next breakpoint
      { "<leader>dc", "<cmd>lua require('dap').continue()<cr>", desc = "Continue" },

      -- Run the current line and move to the next one, without entering called funtions
      { "<leader>ds", "<cmd>lua require('dap').step_over()<cr>", desc = "Step over" },

      -- Enter the funtion called on the current line to debug its body line by line
      { "<leader>di", "<cmd>lua require('dap').step_into()<cr>", desc = "Step into" },

      -- Run the rest of the current function and pause back in the caller
      { "<leader>do", "<cmd>lua require('dap').step_out()<cr>", desc = "Step out" },

      -- Open or close the DAP UI (scopes, watches, call stack, breakpoints, REPL, console)
      { "<leader>du", "<cmd>lua require('dap').toggle()<cr>", desc = "DAP UI" },

      -- Open a picker with the debouggale target of the Rust project (binary, test, examples) and start gthe chosen one under the debugger
      { "<leader>dr", "<cmd>RustLsp debbuggalbles", desc = "Rust Debbuggales" },

      -- Stop the current debug session and kill the program being debugged
      { "<leader>dt", "<cmd>lua require('dap').terminate()<cr>", desc = "Terminate" },
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"

      dapui.setup()

      -- Adapter for Rust (codelldb)
      -- Install once by hand (ex:. :MasonInstall codelldb)
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.rust = {
        {
          name = "Debug",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }

      -- Open/Close DAP UI Automatically
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
}
