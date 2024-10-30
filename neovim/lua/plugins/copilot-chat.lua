local plugins = {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    lazy = false,
    dependencies = {
      { "github/copilot.vim" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
    },
    -- See Commands section for default commands if you want to lazy load on them
    -- enable
    -- event = "VeryLazy",
    keys = {
      { "<leader>cc", "<cmd>CopilotChatOpen<cr>", desc = "CopilotChat - Open chat" },
      -- Call copilot explain in normal, visual and select mode
      { mode = "x", "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain selected code" },
      { "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
      { "<leader>cr", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Reset chat history and clear buffer" },
    },
  },
}

return plugins
