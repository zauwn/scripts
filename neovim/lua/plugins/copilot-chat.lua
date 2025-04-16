local plugins = {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
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
      { "<leader>cc", "<cmd>CopilotChatOpen<cr>", mode = "n", desc = "CopilotChat - Open chat" },
      {
        "<leader>cr",
        "<cmd>CopilotChatReset<cr>",
        mode = "n",
        desc = "CopilotChat - Reset chat history and clear buffer",
      },
      { "<leader>ce", "<cmd>CopilotChatExplain<cr>", mode = "v", desc = "CopilotChat - Explain selected code" },
      { "<leader>co", "<cmd>CopilotChatOptimize<cr>", mode = "v", desc = "CopilotChat - Optimize selected code" },
      { "<leader>cf", "<cmd>CopilotChatFix<cr>", mode = "v", desc = "CopilotChat - Fix selected code issues" },
    },
  },
}

return plugins
