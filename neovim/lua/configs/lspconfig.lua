local configs = require "nvchad.configs.lspconfig"

configs.defaults()

local servers = {
  "lua_ls",
  "bashls",
  "yamlls",
  "pyright",
  "terraformls",
  "helm_ls",
  "html",
  "cssls",
  "clangd",
  "gopls",
  "sqlls",
  "marksman",
}

if vim.lsp and vim.lsp.enable then
  for _, lsp in ipairs(servers) do
    vim.lsp.enable(lsp)
  end
else
  local lspconfig = require "lspconfig"
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      on_init = configs.on_init,
      on_attach = configs.on_attach,
      capabilities = configs.capabilities,
    }
  end
end
