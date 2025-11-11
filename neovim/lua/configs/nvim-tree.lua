-- Description: Configuration for nvim-tree plugin in NvChad
local configs = require "nvchad.configs.nvimtree"

-- custom options for nvim-tree
local options = {
  view = {
    relativenumber = true,
  },
  renderer = {
    full_name = true,
  },
}
-- merge user configs with default configs
configs = vim.tbl_deep_extend("force", configs or {}, options)

require("nvim-tree").setup(configs)
