vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

function Tabsize(num)
    vim.cmd("set tabstop=" .. num)
    vim.cmd("set softtabstop=" .. num)
    vim.cmd("set shiftwidth=" .. num)
end

function Realtab()
    vim.cmd("set softtabstop=0 noexpandtab")
end

function Spacetab()
    vim.cmd("set expandtab")
end
