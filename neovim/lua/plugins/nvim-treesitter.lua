local plugins = {
  {
    "nvim-treesitter/nvim-treesitter",
    -- configure tree sitter
    opts = {
      ensure_installed = {
        -- defaults
        "vim",
        "lua",
        "vimdoc",

        -- web dev
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",

        -- devops
        "yaml",
        "json",
        "python",
        "bash",
        "helm",
        "dockerfile",
        "terraform",
        "groovy",

        -- other
        "go",
        "gitignore",
        "query",
        "markdown",

        -- low level
        "c",
        "zig",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-Space>",
          node_incremental = "<C-Space>",
          scope_incremental = false,
          node_decremental = "<BS>",
        },
      },
    },
  },
}

return plugins
