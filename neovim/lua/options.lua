require "nvchad.options"

-- Local options

local opt = vim.opt

-- tabs and indentation
opt.wrap = false

-- search options
opt.ignorecase = true
opt.smartcase = true


-- Clipboard - Requires xclip
-- opt.clipboard = "unnamedplus"

-- Filetype additional mappings
vim.filetype.add({
  pattern = {
    ['Jenkinsfile.*'] = "groovy",
    ['Dockerfile.*'] = "dockerfile",
    ['.*Dockerfile'] = "dockerfile",
  },
})
