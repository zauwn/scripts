return {
    "folke/persistence.nvim",
    lazy = false, -- Load plugin at startup
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {
      save_empty = false, -- don't save an empty session
      -- add any custom options here
    },
}

