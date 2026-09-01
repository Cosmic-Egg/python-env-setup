
vim.pack.add({
    "https://github.com/folke/flash.nvim",
})
require("flash").setup()
vim.keymap.set({ "n", "x", "o" }, "gw", function()
    require("flash").jump()
end, {
    desc = "Goto word",
})
