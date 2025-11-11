-- Description: nvim-tree plugin specification for loading custom configs
local plugins = {
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require "configs.nvim-tree"
    end,
  },
}

return plugins
