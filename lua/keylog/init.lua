-- Declare a module 'M' with an initial state indicating whether the plugin is enabled.
local M = {}
M.is_plugin_enabled = false

-- Set the log file path to a file named 'keystroke.log' in the Neovim data directory.
M.log_file_path = vim.fn.stdpath('data') .. '/keystroke.log'

-- Function to convert special key presses to a string format for logging.
function M.key2str(key)
    -- Handle control characters.
    local nr = vim.fn.char2nr(key)
    local nr_without_ctrl = nr + 96
    if nr_without_ctrl >= 97 and nr_without_ctrl <= 122 then
        return "<C-" .. vim.fn.nr2char(nr_without_ctrl) .. ">"
    else
        return key
    end
end

-- Function to log a single keystroke to the designated file.
function M.log_keystroke(key)
    if M.is_plugin_enabled then
      local char = M.key2str(key)  -- Convert the key to its string representation.
      local file = io.open(M.log_file_path, 'a')  -- Open the log file in append mode.
      if file then
          file:write(char)  -- Write the character to the file.
          file:close()  -- Close the file after writing.
      end
    end
end

-- Function to clear the log file.
function M.clear()
    local file = io.open(M.log_file_path, 'w')  -- Open the log file in write mode to clear it.
    if file then
        file:write('')  -- Write an empty string to the file, effectively clearing it.
        file:close()
    end
end
-- Define a table 'commands' with functions imported from the 'keylog' module.
-- Each function corresponds to a different command related to key logging.
local commands = {
   enable = M.enable,  -- Load and store the 'enable' function from 'keylog'.
   disable = M.disable, -- Load and store the 'disable' function from 'keylog'.
   toggle = M.toggle,  -- Load and store the 'toggle' function from 'keylog'.
   clear= M.clear,  -- Load and store the 'clear' function from 'keylog'.
}

-- Placeholder setup function for the keylogger command.
function M.setup()
   -- Create a user command 'Keylog' in Neovim using vim.api.nvim_create_user_command.
   vim.api.nvim_create_user_command("Keylog", function(args)
      -- If the argument provided matches a command in the 'commands' table, execute it.
    if commands[args.args] then
        commands[args.args]()
    else
        print("Invalid command. Use: enable, disable, toggle, or clear.")
    end
   end, {
      nargs = 1,  -- This command requires exactly one argument.
      complete = function()
         -- Provide autocompletion options for the command.
         return { "enable", "disable", "toggle", "clear" }
      end,
   })

end

-- Enable the keylogger.
function M.enable()
    if M.is_plugin_enabled then
        return  -- If already enabled, do nothing.
    end
    M.is_plugin_enabled = true
    print("Keylog started")

    -- Create an autocommand that logs every yank (copy) operation's content.
    vim.api.nvim_create_autocmd({"TextYankPost"}, {
        callback = function() M.log_keystroke(vim.v.event.regcontents[1]) end
    })
end

-- Disable the keylogger.
function M.disable()
    if not M.is_plugin_enabled then
        return  -- If already disabled, do nothing.
    end

    M.is_plugin_enabled = false
    print("Keylog stopped")
end

-- Toggle the state of the keylogger.
function M.toggle()
    -- If enabled, disable it; otherwise, enable it.
    (M.is_plugin_enabled and M.disable or M.enable)()
end

-- Return the module for external use.
return M

