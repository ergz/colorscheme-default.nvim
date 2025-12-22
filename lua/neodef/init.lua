local M = {}

M.config = {
    mood = "default", -- "calm" | "default" | "intense"
}

function M.setup(opts)
    M.config = vim.tbl_deep_extend("force", M.config, opts or {})
    M.load()
end

function M.load()
    vim.api.nvim_command('hi clear')
    vim.o.termguicolors = true
    vim.g.colors_name = "neodef"

    local U = require('neodef.utils')
    local P = require('neodef.palette').get_palette(M.config.mood)
    local groups = require("neodef.groups")
    U.set_highlights_table(groups(P))
end

vim.api.nvim_create_user_command("Neodef", function(opts)
    if opts.args == "" then
        vim.cmd.colorscheme("neodef")
    elseif opts.args == "palette" then
        require("neodef.palette").print_palette(M.config.mood)
    elseif opts.args == "calm" or opts.args == "intense" or opts.args == "default" then
        M.config.mood = opts.args
        vim.cmd.colorscheme("neodef")
    else
        vim.notify("Unknown argument: " .. opts.args, vim.log.levels.ERROR)
    end
end, {
    nargs = "?",
    complete = function(_, _)
        return { "palette", "calm", "default", "intense" }
    end
})

return M
