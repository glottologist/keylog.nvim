local M = {}
M.is_plugin_enabled = false

-- Specify the path to the log file
M.log_file_path = vim.fn.stdpath('data') .. '/keystroke.log'
M.log_file_path_raw = vim.fn.stdpath('data') .. '/keystroke_raw.log'


function M.key2str(key)
--[[    if key == "<Esc>" then
        return "<Esc>"
    elseif key == "<CR>" then
        return "<CR>"
    elseif key == "<BS>" then
        return "<BS>"
    elseif key == "<Tab>" then
        return "<Tab>"
    elseif key == " " then
        return "<Space>"
    end
    ]]--
    local nr = vim.fn.char2nr(key)
    local nr_without_ctrl = nr + 96
    if nr_without_ctrl >= 97 and nr_without_ctrl <= 122 then
        return "<C-" .. vim.fn.nr2char(nr_without_ctrl) .. ">"
    else
        return key
    end
end

-- Function to log a single keystroke
function M.log_keystroke(key)
print("Key pressed")
    local file = io.open(M.log_file_path_raw, 'a')
    if file then
        file:write(key)
        file:close()
    end
    local char = M.key2str(key)
    local file = io.open(M.log_file_path, 'a')
    if file then
        file:write(char)
        file:close()
    end
end

-- Setup function to map the keylogger to all printable ASCII characters
function M.setup()
print("Setup keylog")
end

-- Start and stop keycasting
function M.start()
     if M.is_plugin_enabled then
      return
   end

   M.is_plugin_enabled = true
   print("Keylog started")

    vim.api.nvim_create_autocmd({"TextYankPost"}, {
        callback = function() M.log_keystroke(vim.v.event.regcontents[1]) end
    })
end

function M.stop()
   if not M.is_plugin_enabled then
      return
   end

   M.is_plugin_enabled = false
   print("Keylog stopped")
    -- Stop handling, close popups etc.
end

function M.toggle()
   (M.is_plugin_enabled and M.disable or M.enable)()
end
-- Restore options and cleanup
return M
