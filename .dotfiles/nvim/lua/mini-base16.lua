
require("mini.base16").setup({
    palette = {
        base00 = "#191E24",
        base01 = "#305988",
        base02 = "#415162",
        base03 = "#7088A4",
        base04 = "#5892D5",
        base05 = "#BFD9F7",
        base06 = "#C3DFD6",
        base07 = "#AFF8E0",
        base08 = "#446A5D",
        base09 = "#4FDEAE",
        base0A = "#6BA894",
        base0B = "#2C9B76",
        base0C = "#AFF8E0",
        base0D = "#5892D5",
        base0E = "#4FDEAE",
        base0F = "#305988",
    },
})

-- -- Current line
-- vim.api.nvim_set_hl(0, "CursorLine", {
--     bg = "#242C35",
-- })
vim.opt.cursorlineopt = "line"
local bg = "#191E24"
local fg = "#5892D5"
local muted = "#7088A4"
local accent = "#4FDEAE"

-- Gutter / line numbers
vim.api.nvim_set_hl(0, "LineNr", {
    fg = muted,
    bg = bg,
})

vim.api.nvim_set_hl(0, "LineNrAbove", {
    fg = muted,
    bg = bg,
})

vim.api.nvim_set_hl(0, "LineNrBelow", {
    fg = muted,
    bg = bg,
})

vim.api.nvim_set_hl(0, "CursorLineNr", {
    fg = accent,
    bg = bg,
    bold = true,
})

vim.api.nvim_set_hl(0, "SignColumn", {
    bg = bg,
})

-- Current line
vim.api.nvim_set_hl(0, "CursorLine", {
    bg = "#202832",
})

-- Status line
vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", {
    fg = bg,
    bg = "#5892D5",
    bold = true,
})

vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo", {
    fg = "#BFD9F7",
    bg = "#305988",
})

vim.api.nvim_set_hl(0, "MiniStatuslineFilename", {
    fg = "#BFD9F7",
    bg = "#242C35",
})

vim.api.nvim_set_hl(0, "MiniStatuslineFileinfo", {
    fg = "#BFD9F7",
    bg = "#305988",
})

-- Pickers
vim.api.nvim_set_hl(0, "MiniPickNormal", {
    bg = "#191E24",
})

vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", {
    bg = "#202832",
})
