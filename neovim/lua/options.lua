require "nvchad.options"

-- Local options
local opt = vim.opt

-- tabs and indentation
opt.wrap = true

-- scroll offset
opt.scrolloff = 3
opt.relativenumber = true

-- search options
opt.ignorecase = true
opt.smartcase = true

-- Save undo history
vim.o.undofile = true

-- Clipboard - Requires xclip
-- opt.clipboard = "unnamedplus"

-- Filetype additional mappings
vim.filetype.add {
  pattern = {
    ["Jenkinsfile.*"] = "groovy",
    ["Dockerfile.*"] = "dockerfile",
    [".*Dockerfile"] = "dockerfile",
    [".*/charts/.*%.yaml"] = "helm",
  },
  extension = {
    psql = "sql",
    pgsql = "sql",
  },
}

-- Set commentstring for sql files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "sql",
  callback = function()
    vim.bo.commentstring = "-- %s"
  end,
})
