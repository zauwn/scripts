local plugins = {
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      {
        "kristijanhusak/vim-dadbod-completion",
        ft = {
          "sql",
          "mysql",
          "plsql",
        },
        lazy = true,
        config = function()
          -- This autocommand sets the omnifunction only after the plugin is loaded
          vim.api.nvim_create_autocmd("FileType", {
            pattern = { "sql", "mysql", "plsql" },
            callback = function()
              vim.bo.omnifunc = "vim_dadbod_completion#omni"
            end,
          })
        end,
      },
    },
    cmd = {
      "DBUI", -- Open the Dadbod UI
      "DBUIToggle", -- Toggle the Dadbod UI
      "DBUIAddConnection", -- Add a DBUIAddConnection
      "DBUIFindBuffer", -- Find the buffer
    },
    init = function()
      -- You can pass options to `DBUI` and `DBUIToggle` commands
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
}

return plugins
