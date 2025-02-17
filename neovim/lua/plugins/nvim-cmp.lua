local plugins = {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      table.insert(opts.sources, { name = "vim-dadbod-completion" }) -- Add vim-dadbod-completion as a source
    end,
  },
}

return plugins
