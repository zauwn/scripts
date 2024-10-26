-- This file  needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "tokyodark",
  theme_toggle = { "tokyodark", "one_light" }
}

M.ui = {
  tabufline = {
    lazyload = false,
  }
}

-- M.nvdash = {
--   active = true,
--   load_on_startup = true
-- }

return M
