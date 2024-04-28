local commands = {
   enable = require("keylog").enable,
   disable = require("keylog").disable,
   toggle = require("keylog").toggle,
}

local M = {}

function M.setup()
   vim.api.nvim_create_user_command("Keylog", function(args)
      if commands[args.args] then
         commands[args.args]()
      end
   end, {
      nargs = 1,
      complete = function()
         return { "enable", "disable", "toggle"}
      end,
   })
end

return M
