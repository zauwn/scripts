require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")


map("i", "<C-l>", "<cmd>lua vim.fn.feedkeys(vim.fn['copilot#Accept'](), '')<CR>", { desc = "Copilot Accept" })


-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- neovim most used mappings
