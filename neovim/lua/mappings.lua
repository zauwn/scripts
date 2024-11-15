require "nvchad.mappings"

-- custom mappings

local map = vim.keymap.set

-- vim goodies
-- map("n", ";",  ":",     { desc = "Semi-colon (;) as a colon (:)" })
map("i", "jk", "<ESC>", { desc = "Escape to Normal Mode" })
map("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit All" })

-- Copilot
map("i", "<C-CR>", "<cmd>lua vim.fn.feedkeys(vim.fn['copilot#Accept'](), '')<CR>", { desc = "Copilot Accept" })
map("n", "<C-CR>", ":Copilot panel <cr>", { desc = "Copilot Panel" })

-- auto-save
-- map("n", "<leader>wr", "<cmd> SessionRestore <cr>", { desc = "Restore Session" --[[ }) ]]
-- map("n", "<leader>ws", "<cmd> SessionSave <cr>", { desc = "Save Session" })

-- persistence
map("n", "<leader>qs", "<cmd>lua require('persistence').load()<cr>", { desc = "Restore session" })
map("n", "<leader>qt", "<cmd>lua require('persistece').stop()<cr>", { desc = "Don't save session on exit" })
map("n", "<leader>ql", "<cmd>lua require('persistence').load({ load = true })<cr>", { desc = "Restore last session" })

-- conform (already default)
-- map("n", "<leader>fm", "<cmd>lua require('conform').format()<cr>", { desc = "Format file" })

-- gitsigns
map("n", "<leader>gb", "<cmd>lua require('gitsigns').blame_line()<cr>", { desc = "Git - Blame Line" })
map("n", "<leader>tb", "<cmd>lua require('gitsigns').toggle_current_line_blame()<cr>", { desc = "Toggle Git Blame" })
map("n", "<leader>gd", "<cmd>lua require('gitsigns').diffthis('~1')<cr>", { desc = "Git - Diff This" })
map("n", "<leader>gs", "<cmd>lua require('gitsigns').stage_hunk()<cr>", { desc = "Git - Stage Hunk" })
map("n", "<leader>gu", "<cmd>lua require('gitsigns').undo_stage_hunk()<cr>", { desc = "Git - Undo Stage Hunk" })
map("n", "<leader>gr", "<cmd>lua require('gitsigns').reset_hunk()<cr>", { desc = "Git - Reset Hunk" })
map("n", "<leader>gP", "<cmd>lua require('gitsigns').preview_hunk()<cr>", { desc = "Git - Preview Hunk" })
map("n", "<leader>gn", "<cmd>lua require('gitsigns').next_hunk()<cr>", { desc = "Git - Next Hunk" })
map("n", "<leader>gp", "<cmd>lua require('gitsigns').previous_hunk()<cr>", { desc = "Git - Previous Hunk" })
map("n", "<leader>gn", "<cmd>lua require('gitsigns').next_hunk()<cr>", { desc = "Git - Next Hunk" })
map("n", "<leader>gp", "<cmd>lua require('gitsigns').previous_hunk()<cr>", { desc = "Git - Previous Hunk" })
map("n", "<leader>gS", "<cmd>lua require('gitsigns').stage_buffer()<cr>", { desc = "Git - Stage Buffer" })
map("n", "<leader>gR", "<cmd>lua require('gitsigns').reset_buffer()<cr>", { desc = "Git - Reset Buffer" })
map("n", "<leader>td", "<cmd>lua require('gitsigns').toggle_deleted()<cr>", { desc = "Git - Toggle Deleted" })
