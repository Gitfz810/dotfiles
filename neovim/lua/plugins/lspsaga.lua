local M = {}

function M.setup()
  local config = {
    -- when there has code action it will show a lightbulb
    lightbulb = {
      enable = false,
      sign = false,
    },
    beacon = {
      enable = false,
    },
    finder = {
      keys = {
        toggle_or_open = "<CR>",
        quit = "q",
        close = "<ESC>",
      },
    },
    rename = {
      in_select = false,
    },
    definition = {
      keys = {
        tabnew = "<C-c>n",
      },
    },
  }

  local saga = require("lspsaga")
  saga.setup(config)
end

return M
