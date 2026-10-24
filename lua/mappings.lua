require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Debugging (nvim-dap)
map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "DAP Toggle breakpoint" })
map("n", "<F5>", function() require("dap").continue() end, { desc = "DAP Continue" })
map("n", "<F10>", function() require("dap").step_over() end, { desc = "DAP Step over" })
map("n", "<F11>", function() require("dap").step_into() end, { desc = "DAP Step into" })
map("n", "<F12>", function() require("dap").step_out() end, { desc = "DAP Step out" })
map("n", "<leader>du", function() require("dapui").toggle() end, { desc = "DAP Toggle UI" })
