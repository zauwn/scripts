require "nvchad.mappings"

-- custom mappings

local map = mapvim.keymap.set

-- vim goodies
map("n", ";",  ":",     { desc = "Semi-colon (;) as a colon (:)" })
map("i", "jk", "<ESC>", { desc = "jk to escape to normal mode" })

-- Copilot
map("i", "<C-CR>", "<cmd>lua vim.fn.feedkeys(vim.fn['copilot#Accept'](), '')<CR>" , { desc = "Copilot Accept" })
map("n", "<C-CR>", ":Copilot panel <cr>"                                          , { desc = "Copilot Panel" })

-- auto-save
map("n", "<leader>wr", "<cmd> SessionRestore <cr>", { desc = "Restore Session" })
map("n", "<leader>ws", "<cmd> SessionSave <cr>", { desc = "Save Session" })

