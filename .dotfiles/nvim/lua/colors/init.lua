local M = {}

local function hl(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

function M.setup(name)
    local p = require("colors.palettes." .. name)

    local c = {
        bg = p.base00,
        bg_alt = p.base01,
        bg_select = p.base02,

        fg_muted = p.base03,
        fg_dim = p.base04,
        fg = p.base05,
        fg_bright = p.base07,

        accent = p.base0D,
        accent_alt = p.base0E,
    }

    vim.opt.termguicolors = true

    require("mini.base16").setup({
        palette = p,
    })

    -- Editor
    hl("Normal", {
        fg = c.fg,
        bg = c.bg,
    })

    hl("CursorLine", {
        bg = c.bg_alt,
    })

    hl("Visual", {
        bg = c.bg_select,
    })

    -- Gutter
    hl("LineNr", {
        fg = c.fg_muted,
        bg = c.bg,
    })

    hl("LineNrAbove", {
        fg = c.fg_muted,
        bg = c.bg,
    })

    hl("LineNrBelow", {
        fg = c.fg_muted,
        bg = c.bg,
    })

    hl("CursorLineNr", {
        fg = c.accent,
        bg = c.bg,
        bold = true,
    })

    hl("SignColumn", {
        bg = c.bg,
    })

    hl("FoldColumn", {
        fg = c.fg_muted,
        bg = c.bg,
    })

    hl("CursorLineSign", {
        bg = c.bg,
    })

    hl("CursorLineFold", {
        bg = c.bg,
    })

    -- Floating windows
    hl("NormalFloat", {
        fg = c.fg_bright,
        bg = c.bg,
    })

    hl("FloatBorder", {
        fg = c.fg_muted,
        bg = c.bg,
    })

    hl("FloatTitle", {
        fg = c.accent,
        bg = c.bg,
        bold = true,
    })

    -- MiniPick
    hl("MiniPickNormal", {
        fg = c.fg_bright,
        bg = c.bg,
    })

    hl("MiniPickBorder", {
        fg = c.fg_muted,
        bg = c.bg,
    })

    hl("MiniPickBorderText", {
        fg = c.accent,
        bg = c.bg,
        bold = true,
    })

    hl("MiniPickPrompt", {
        fg = c.accent,
        bg = c.bg,
    })

    hl("MiniPickMatchCurrent", {
        bg = c.bg_alt,
    })

    hl("MiniPickMatchMarked", {
        fg = c.accent_alt,
        bg = c.bg,
    })

    hl("MiniPickMatchRanges", {
        fg = c.accent,
        bold = true,
    })

    -- MiniStatusline
    hl("MiniStatuslineModeNormal", {
        fg = c.bg,
        bg = c.accent,
        bold = true,
    })

    hl("MiniStatuslineModeInsert", {
        fg = c.bg,
        bg = p.base0B,
        bold = true,
    })

    hl("MiniStatuslineModeVisual", {
        fg = c.bg,
        bg = p.base0E,
        bold = true,
    })

    hl("MiniStatuslineModeReplace", {
        fg = c.bg,
        bg = p.base08,
        bold = true,
    })

    hl("MiniStatuslineModeCommand", {
        fg = c.bg,
        bg = p.base0A,
        bold = true,
    })

    hl("MiniStatuslineDevinfo", {
        fg = c.fg_bright,
        bg = c.bg_select,
    })

    hl("MiniStatuslineFilename", {
        fg = c.fg,
        bg = c.bg_alt,
    })

    hl("MiniStatuslineFileinfo", {
        fg = c.fg_bright,
        bg = c.bg_select,
    })

    hl("MiniStatuslineInactive", {
        fg = c.fg_muted,
        bg = c.bg,
    })
end

return M
