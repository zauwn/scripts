require "nvchad.mappings"

-- custom mappings

local map = vim.keymap.set

-- vim goodies
-- map("n", ";",  ":",     { desc = "Semi-colon (;) as a colon (:)" })
map("i", "jk", "<ESC>", { desc = "jk to escape to normal mode" })

-- Copilot
map("i", "<C-CR>", "<cmd>lua vim.fn.feedkeys(vim.fn['copilot#Accept'](), '')<CR>" , { desc = "Copilot Accept" })
map("n", "<C-CR>", ":Copilot panel <cr>"                                          , { desc = "Copilot Panel" })

-- auto-save
-- map("n", "<leader>wr", "<cmd> SessionRestore <cr>", { desc = "Restore Session" --[[ }) ]]
-- map("n", "<leader>ws", "<cmd> SessionSave <cr>", { desc = "Save Session" })

-- persistence
map("n", "<leader>qs", "<cmd>lua require('persistence').load()<cr>", { desc = "Restore session" })
map("n", "<leader>qt", "<cmd>lua require('persistence').stop()<cr>", { desc = "Don't save session on exit" })
map("n", "<leader>ql", "<cmd>lua require('persistence').load({ load = true })<cr>", { desc = "Restore last session" })

