local plugins = {
  {
    -- github.com/milanglacier/minuet-ai.nvim
    -- setup Ollama locally to use as an AI provider
    "milanglacier/minuet-ai.nvim",
    lazy = false,
    config = function()
      require("minuet").setup {
        -- Mistral Configuration
        provider = "codestral",
        n_completions = 1,
        throttle = 1500,
        debounce = 600,
        -- to change providers use:
        --:Minuet change_provider codestral|openai_fim_compatible
        provider_options = {
          codestral = {
            model = "codestral-latest",
            end_point = "https://api.mistral.ai/v1/fim/completions",
            api_key = "MISTRAL_API_KEY", -- environment-variable name, not the key itself
            optional = {
              max_tokens = 128,
            },
          },
          openai_fim_compatible = {
            name = "Ollama",
            end_point = "http://localhost:11434/v1/completions",
            model = "qwen2.5-coder:3b",
            api_key = "TERM", -- environment-variable name; Ollama needs no real key
            optional = {
              max_tokens = 56,
              top_pr = 0.9,
            },
          },
        },

        virtualtext = {
          -- disabled on start
          --:Minuet virtualtext enable|disable|toggle
          auto_trigger_ft = {},
          keymap = {
            -- accept whole completion
            accept = "<A-A>",
            -- accept one line
            accept_line = "<A-a>",
            -- accept n lines (prompts for number)
            -- e.g. "A-z 2 CR" will accept 2 lines
            accept_n_lines = "<A-z>",
            -- Cycle to prev completion item, or manually invoke completion
            prev = "<A-[>",
            -- Cycle to next completion item, or manually invoke completion
            next = "<A-]>",
            dismiss = "<A-e>",
          },
        },
      }
    end,
  },
}

return plugins
