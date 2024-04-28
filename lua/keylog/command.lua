-- Define a table 'commands' with functions imported from the 'keylog' module.
-- Each function corresponds to a different command related to key logging.
local commands = {
   enable = require("keylog").enable,  -- Load and store the 'enable' function from 'keylog'.
   disable = require("keylog").disable, -- Load and store the 'disable' function from 'keylog'.
   toggle = require("keylog").toggle,  -- Load and store the 'toggle' function from 'keylog'.
   clear= require("keylog").clear,  -- Load and store the 'clear' function from 'keylog'.
}

-- Create a local table 'M' to hold module functions.
local M = {}

-- Define the 'setup' function in the module 'M'.
-- This function sets up a new user command in Neovim for managing key logging.
function M.setup()
   -- Create a user command 'Keylog' in Neovim using vim.api.nvim_create_user_command.
   vim.api.nvim_create_user_command("Keylog", function(args)
      -- If the argument provided matches a command in the 'commands' table, execute it.
      if commands[args.args] then
         commands[args.args]()
      end
   end, {
      nargs = 1,  -- This command requires exactly one argument.
      complete = function()
         -- Provide autocompletion options for the command.
         return { "enable", "disable", "toggle", "clear" }
      end,
   })
end
