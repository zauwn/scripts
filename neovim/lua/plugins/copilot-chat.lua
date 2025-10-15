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
      default_agent = "claude-sonnet-4", -- default agent to use
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
      {
        "<leader>cq",
        function()
          local input = vim.fn.input "Quick Chat: "
          if input ~= "" then
            require("CopilotChat").ask(input, {
              selection = require("CopilotChat.select").buffer,
            })
          end
        end,
        mode = { "n", "v" },
        desc = "CopilotChat - Quick chat",
      },
    },
  },
}

return plugins
