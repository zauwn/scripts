local plugins = {
  {
    "rmagatti/auto-session",
    lazy = false,

    opts = {
      auto_session_suppress_dirs = { "~/", "~/Downloads/*", "~/Documents/*" },
      auto_session_enable_last_session = true,
      auto_save_enabled = true,
      auto_restore_enabled = true,
    },
  }
}

return plugins
