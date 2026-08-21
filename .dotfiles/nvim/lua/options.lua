vim.o.nu = true
vim.o.relativenumber = true
vim.o.swapfile = false
vim.o.smartcase = true
vim.o.ignorecase = true


vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    callback = function()
        vim.hl.on_yank()
    end,
})
