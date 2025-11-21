-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua
---@diagnostic disable: undefined-global

local M = {}

M.base46 = {
  theme = "tokyonight",
  theme_toggle = { "tokyonight", "one_light" },
}

-- helper function to get the current buffer
local stbufnr = function()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

M.ui = {
  tabufline = {
    lazyload = false,
  },
  statusline = {
    -- default = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
    -- vscode = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cursor", "cwd" },
    order = {
      "mode",
      "ft",
      "file",
      "git",
      "%=",
      "lsp_msg",
      "%=",
      "diagnostics",
      "lsp",
      "cwd",
      "relativepath",
      "cursor",
    },
    modules = {
      relativepath = function()
        local path = stbufnr()
        if path == "" then
          return ""
        end
        return "/%#St_cwd_text#" .. vim.fn.expand "%:.:h" .. " "
      end,

      ft = "%#St_file#" .. " %y ",
      f = "%f",
    },
  },
}

-- M.nvdash = {
--   active = true,
--   load_on_startup = true
-- }

return M
