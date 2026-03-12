return {
  "folke/sidekick.nvim",
  -- Minimal init without autocommands that might conflict
  init = function()
    -- Basic terminal settings only
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "*",
      callback = function()
        vim.opt_local.scrolloff = 0
      end,
    })
  end,
  opts = {
    cli = {
      mux = { enabled = false },
      tools = {
        -- Factory Droid - Interactive mode
        droid = {
          cmd = { "droid" },
        },
        -- RovoDev - AI development assistant
        rovodev = {
          cmd = { "acli", "rovodev", "run" },
        },
        -- Codex - Code search and generation
        codex = {
          cmd = { "codex", "--search" },
        },
        -- GitHub Copilot CLI - Code generation and chat
        copilot = {
          cmd = { "copilot", "--banner" },
        },
        -- Claude CLI - Anthropic conversational AI
        claude = {
          cmd = { "claude", "--model", "claude-opus-4-6-thinking" },
        },
        -- Google Gemini CLI
        gemini = {
          cmd = { "gemini" },
        },
        -- Grok CLI - xAI assistant
        grok = {
          cmd = { "grok" },
        },

        qodercli = {
          cmd = { "qodercli" },
        },
        opencode = {
          cmd = { "opencode" },
        },
      },
    },
  },
  keys = {
    {
      "<tab>",
      function()
        if not require("sidekick").nes_jump_or_apply() then
          return "<Tab>"
        end
      end,
      expr = true,
      desc = "Goto/Apply Next Edit Suggestion",
    },
    {
      "<c-.>",
      function()
        require("sidekick.cli").toggle()
      end,
      desc = "Sidekick Toggle",
      mode = { "n", "t", "i", "x" },
    },
    {
      "<leader>aa",
      function()
        require("sidekick.cli").toggle({ focus = true })
      end,
      desc = "Agent Menu (All Tools)",
      mode = { "n", "v" },
    },
    {
      "<leader>aA",
      function()
        -- Close current session first, then open agent menu
        require("sidekick.cli").close()
        vim.defer_fn(function()
          require("sidekick.cli").toggle({ focus = true })
        end, 100)
      end,
      desc = "New Agent Menu (Force Close & Open)",
      mode = { "n", "v" },
    },
    {
      "<leader>aq",
      function()
        pcall(function()
          require("sidekick.cli").close()
        end)
        -- Force close terminal buffer after short delay
        vim.defer_fn(function()
          pcall(function()
            if vim.bo.buftype == "terminal" then
              local job_id = vim.b.terminal_job_id
              if job_id then
                vim.fn.jobstop(job_id)
              end
              vim.cmd("bdelete!")
            end
          end)
        end, 200)
      end,
      desc = "Quit/Close Agent",
      mode = { "n", "t" },
    },
    {
      "<leader>aQ",
      function()
        -- Store current buffer info
        local current_buf = vim.api.nvim_get_current_buf()
        local job_id = vim.b.terminal_job_id

        -- Force close session
        pcall(function()
          require("sidekick.cli").close()
        end)

        -- Kill terminal job and delete buffer
        vim.defer_fn(function()
          pcall(function()
            -- Kill the terminal job first
            if job_id then
              vim.fn.jobstop(job_id)
            end
            -- Find and switch to a safe buffer
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "" then
                vim.api.nvim_set_current_buf(buf)
                break
              end
            end
            -- Force delete the terminal buffer
            if vim.api.nvim_buf_is_valid(current_buf) then
              vim.api.nvim_buf_delete(current_buf, { force = true })
            end
          end)
        end, 100)
      end,
      desc = "Force Kill Agent Session",
      mode = { "n", "t" },
    },
    {
      "<leader>aqq",
      function()
        -- Force kill all terminal processes and close buffers
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "terminal" then
            local job_id = vim.api.nvim_buf_get_var(buf, "terminal_job_id")
            if job_id then
              pcall(function()
                vim.fn.jobstop(job_id)
              end)
            end
            pcall(function()
              vim.api.nvim_buf_delete(buf, { force = true })
            end)
          end
        end
        pcall(function()
          require("sidekick.cli").close()
        end)
        vim.notify("All agent sessions killed", vim.log.levels.INFO)
      end,
      desc = "Kill All Agent Sessions",
      mode = { "n", "t" },
    },
    {
      "<leader>at",
      function()
        require("sidekick.cli").send({ msg = "{this}" })
      end,
      mode = { "x", "n" },
      desc = "Send This",
    },
    {
      "<leader>af",
      function()
        require("sidekick.cli").send({ msg = "{file}" })
      end,
      desc = "Send File",
    },
    {
      "<leader>av",
      function()
        require("sidekick.cli").send({ msg = "{selection}" })
      end,
      mode = { "x" },
      desc = "Send Visual Selection",
    },
    {
      "<leader>ap",
      function()
        require("sidekick.cli").prompt()
      end,
      mode = { "n", "x" },
      desc = "Prompt Templates",
    },
    {
      "<leader>ac",
      function()
        require("sidekick.cli").toggle({ name = "claude", focus = true })
      end,
      desc = "Claude Agent",
      mode = { "n", "v" },
    },
    {
      "<leader>ad",
      function()
        require("sidekick.cli").toggle({ name = "droid", focus = true })
      end,
      desc = "Factory Droid Agent",
      mode = { "n", "v" },
    },

    {
      "<leader>ax",
      function()
        require("sidekick.cli").toggle({ name = "codex", focus = true })
      end,
      desc = "Codex Agent",
      mode = { "n", "v" },
    },
    {
      "<leader>aC",
      function()
        require("sidekick.cli").toggle({ name = "copilot", focus = true })
      end,
      desc = "Copilot CLI Agent",
      mode = { "n", "v" },
    },
    {
      "<leader>ag",
      function()
        require("sidekick.cli").toggle({ name = "gemini", focus = true })
      end,
      desc = "Gemini Agent",
      mode = { "n", "v" },
    },
    {
      "<leader>ar",
      function()
        require("sidekick.cli").toggle({ name = "rovodev", focus = true })
      end,
      desc = "RovoDev Agent",
      mode = { "n", "v" },
    },
    {
      "<leader>an",
      function()
        -- Open agent menu for new session (shows all available tools)
        require("sidekick.cli").toggle({ focus = true })
      end,
      desc = "New Agent Session (Show All)",
      mode = { "n", "v" },
    },
  },
}
