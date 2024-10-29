local options = {
  formatters_by_ft = {
    -- configs
    lua = { "stylua" },
    -- web
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    -- work
    sh = { "shfmt" },
    python = { "isort", "black" },
    json = { "prettier" },
    yaml = { "prettier" },
    sql = { "sql-formatter" },
    markdown = { "prettier" },
    -- other - not usual
    c = { "clang-format" },
    cpp = { "clang-format" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  },
}

require("conform").setup(options)
