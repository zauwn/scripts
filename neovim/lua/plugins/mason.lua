local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP
        "lua-language-server",
        "bash-language-server",
        "yaml-language-server",
        "helm-ls",
        "terraform-ls",
        "pyright",
        "html-lsp",
        "css-lsp",
        "clangd",
        "gopls",
        "sqlls",
        -- Linter
        -- Formatter
        "stylua",
        "prettier",
        "shfmt",
        "isort",
        "black",
        "sqlfmt",
      },
    },
  },
}

return plugins
