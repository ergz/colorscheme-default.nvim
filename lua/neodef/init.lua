local M = {}

M.config = {
    mood = "default", -- "calm" | "default" | "intense"
    overrides = {},   -- table or function(P) that returns table
}

function M.setup(opts)
    M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

function M.load(opts)
    -- Color file opts are defaults, M.config (from setup) takes precedence
    opts = vim.tbl_deep_extend("force", { mood = "default", overrides = {} }, opts or {}, M.config)

    -- Clear cached modules so colorscheme reloads properly when switching themes
    package.loaded["neodef.palette"] = nil
    package.loaded["neodef.groups"] = nil
    package.loaded["neodef.utils"] = nil

    vim.api.nvim_command('hi clear')
    vim.o.termguicolors = true
    vim.g.colors_name = "neodef"

    local U = require('neodef.utils')
    local P = require('neodef.palette').get_palette(opts.mood)
    local groups = require("neodef.groups")(P)

    -- Resolve overrides (table or function)
    local overrides = opts.overrides
    if type(overrides) == "function" then
        overrides = overrides(P)
    end

    -- Merge overrides into groups
    for group, hl_opts in pairs(overrides) do
        if groups[group] then
            groups[group] = vim.tbl_extend("force", groups[group], hl_opts)
        else
            groups[group] = hl_opts
        end
    end

    U.set_highlights_table(groups)
end

vim.api.nvim_create_user_command("Neodef", function(cmd_opts)
    if cmd_opts.args == "" then
        vim.cmd.colorscheme("neodef")
    elseif cmd_opts.args == "palette" then
        require("neodef.palette").print_palette(M.config.mood)
    elseif cmd_opts.args == "calm" or cmd_opts.args == "intense" or cmd_opts.args == "default" then
        M.config.mood = cmd_opts.args
        vim.cmd.colorscheme("neodef")
    else
        vim.notify("Unknown argument: " .. cmd_opts.args, vim.log.levels.ERROR)
    end
end, {
    nargs = "?",
    complete = function(_, _)
        return { "palette", "calm", "default", "intense" }
    end
})

return M
