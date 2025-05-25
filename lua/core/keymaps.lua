-- 定义一个辅助函数来设置映射，并统一选项（非递归映射和静默模式）
local function map(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

-----------------------------
-- 普通模式下的键盘映射 --
-----------------------------
-- 快速保存文件，按 Ctrl + s 保存
vim.g.mapleader = " "

map('n', '<C-s>', ':w<CR>', 'Save current file')

-- 快速选中所有内容，按 Ctrl + a 选中全屏（例如：ggVG）
map('n', '<C-a>', 'ggVG', 'Select all')

-----------------------------
-- 插入模式下的键盘映射 --
-----------------------------
-- 使用 jk 作为退出插入模式的快捷键替代 Esc
map('i', 'jk', '<Esc>', 'Exit Insert mode')

-- 在插入模式下按 Ctrl + s 保存文件（先退出插入模式再保存）
map('i', '<C-s>', '<Esc>:w<CR>', 'Save current file')

-- 撤销 <C-z>
vim.keymap.set("n", "<C-z>", "u", { noremap = true, desc = "Undo" })
vim.keymap.set("i", "<C-z>", "<C-o>u", { noremap = true, desc = "Undo in Insert mode" })

-- 重做 <C-y>（默认 <C-r> 是重做，但可以改成 <C-y>）
vim.keymap.set("n", "<C-y>", "<C-r>", { noremap = true, desc = "Redo" })
vim.keymap.set("i", "<C-y>", "<C-o><C-r>", { noremap = true, desc = "Redo in Insert mode" })
