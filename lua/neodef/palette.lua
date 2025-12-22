local U = require("neodef.utils")

local M = {}

-- Pre-computed palette variants
-- calm: 50% saturation, compressed lightness for grays
-- default: current values from nvim builtins
-- intense: 150% saturation, expanded lightness for grays
local palettes = {
    calm = {
        -- Chromatic colors (desaturated)
        red = "#d49b9b",
        green = "#c3e5ca",
        yellow = "#e2d4ae",
        magenta = "#f1d7f1",
        orange = "#ddae9b",
        blue = "#a3c7dd",
        cyan = "#a6dddc",

        -- Grays (compressed toward middle)
        black = "#131623",
        gray0 = "#21242c",
        gray1 = "#37393f",
        gray2 = "#55585e",

        -- Whites (compressed toward middle)
        white0 = "#d5dced",
        white1 = "#cdd1dd",
        white2 = "#b8bac2",
        white3 = "#95999f",
    },

    default = {
        -- Chromatic colors (nvim builtins)
        red = "#f08080",
        green = "#b3f6c0",
        yellow = "#fce094",
        magenta = "#ffcaff",
        orange = "#ffa07a",
        blue = "#87cefa",
        cyan = "#8cf8f7",

        -- Grays
        black = "#07080d",
        gray0 = "#14161b",
        gray1 = "#2c2e33",
        gray2 = "#4f5258",

        -- Whites
        white0 = "#eef1f8",
        white1 = "#e0e2ea",
        white2 = "#c4c6cd",
        white3 = "#9b9ea4",
    },

    intense = {
        -- Chromatic colors (saturated)
        red = "#ff7171",
        green = "#a9ffba",
        yellow = "#ffe191",
        magenta = "#ffc9ff",
        orange = "#ffa07a",
        blue = "#82cfff",
        cyan = "#84fffd",

        -- Grays (expanded from middle)
        black = "#000000",
        gray0 = "#0b0c0f",
        gray1 = "#24262a",
        gray2 = "#4a4d53",

        -- Whites (expanded from middle)
        white0 = "#fefefe",
        white1 = "#ecedf2",
        white2 = "#cbcdd3",
        white3 = "#9ea1a7",
    },
}

-- Add derived colors (fg, bg, diff, etc.) to a base palette
local function extend_palette(base)
    local P = vim.tbl_extend("force", {}, base)
    P.fg = P.white0
    P.bg = P.gray0
    P.bg_dark = P.black
    P.bg_float = U.blend(P.bg, 0.55, P.bg_dark)
    P.fg_dim = U.blend(P.white2, 0.65, P.bg_dark)
    P.comment = U.blend(P.fg, 0.7, P.bg)
    P.bg_highlight = P.gray1
    P.diff = {
        add = U.blend(P.green, 0.2, P.bg_dark),
        delete = U.blend(P.red, 0.2, P.bg_dark),
        change = U.blend(P.blue, 0.2, P.bg_dark),
        text = P.blue,
    }
    return P
end

function M.get_palette(mood)
    mood = mood or "default"
    if not palettes[mood] then
        vim.notify("Unknown mood: " .. mood .. ", using default", vim.log.levels.WARN)
        mood = "default"
    end
    return extend_palette(palettes[mood])
end

function M.print_palette(mood)
    print(vim.inspect(M.get_palette(mood)))
end

return M
