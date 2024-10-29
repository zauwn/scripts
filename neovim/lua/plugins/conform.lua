local plugins = {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufWritePre" },
    config = function()
      require "configs.conform"
    end,
  },
}

return plugins
