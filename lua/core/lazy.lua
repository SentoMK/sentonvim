local M = {}

function M.setup()
    -- Lazy.nvim 安装检测
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable",
            lazypath
        })
    end

    -- 添加至 runtimepath
    vim.opt.rtp:prepend(lazypath)
end

return M
