local plugins = {
   {
    "piersolenski/wtf.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    keys = {
      -- {
      --   "gW",
      --   mode = { "n", "x" },
      --   function()
      --     require("wtf").ai()
      --   end,
      --   desc = "Debug diagnostic with AI",
      -- },
      {
        mode = { "n" },
        "gw",
        function()
          require("wtf").search()
        end,
        desc = "Search diagnostic with Google",
      },
    },
  }
}

return plugins
