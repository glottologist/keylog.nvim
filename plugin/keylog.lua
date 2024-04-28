if vim.fn.has("nvim-0.7.0") ~= 1 then
   vim.api.nvim_err_writeln("Keylog.nvim requires at least nvim-0.7.0.")
end

vim.api.nvim_create_user_command("Keylog", function(opts)
  local cmd = opts.args
  if cmd ~= "" then
    require("keylog").run(cmd)
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
