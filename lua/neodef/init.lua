local M = {}

function M.load()
    vim.api.nvim_command('hi clear')
    vim.o.termguicolors = true
    vim.g.colors_name = "neodef"

    local U = require('neodef.utils')
    U.set_highlights_table(require("neodef.groups"))
end

vim.api.nvim_create_user_command("Neodef", function(opts)
    if opts.args == "" then
        vim.cmd.colorscheme("neodef")
    elseif opts.args == "palette" then
        require("neodef.palette").print_palette()
    else
        vim.notify("Unknown argument: " .. opts.args, vim.log.levels.ERROR)
    end
end, {
    nargs = "?",
    complete = function(_, _)
        return { "palette" }
    end
})

return M
