-- lua/options.lua

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs / indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true

-- Searching
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- UI
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Keep some context when horizontally scrolling
opt.sidescroll = 1

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Mouse
opt.mouse = "a"

-- Clipboard
-- opt.clipboard = "unnamedplus"

-- Files / undo
opt.swapfile = false
opt.backup = false
opt.undofile = true

-- Completion
opt.completeopt = { "menuone", "noselect", "popup" }

-- Don't wrap long lines
opt.wrap = false

-- Make whitespace easier to see when needed
opt.list = false
opt.listchars = {
    tab = "» ",
    trail = "·",
    nbsp = "␣",
}

-- Faster UI feedback
opt.updatetime = 250

-- Shorter mapped-key timeout
opt.timeoutlen = 400

-- Allow project-specific config files
opt.exrc = true


-- Old Options
-- vim.o.nu = true
-- vim.o.relativenumber = true
-- vim.o.swapfile = false
-- vim.o.smartcase = true
-- vim.o.ignorecase = true
-- vim.opt.wildmenu = true
-- vim.opt.wildmode = "noselect:lastused,full"
-- vim.opt.wildoptions = "pum,fuzzy"
-- vim.opt.autocomplete = true
-- vim.opt.completeopt = { "menu", "menuone", "noselect" }


-- vim.api.nvim_create_autocmd("TextYankPost", {
--     desc = "Highlight when yanking (copying) text",
--     callback = function()
--         vim.hl.on_yank()
--     end,
-- })

-- vim.api.nvim_create_autocmd("LspAttach", {
--     callback = function(args)
--         local client = vim.lsp.get_client_by_id(args.data.client_id)

--         if client and client:supports_method("textDocument/completion") then
--             vim.lsp.completion.enable(true, client.id, args.buf, {
--                 autotrigger = true,
--             })
--         end
--     end,
-- })
