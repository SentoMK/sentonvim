return {
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup({
      toggler = {
        line = '<leader>cc', -- 行注释切换
        block = '<leader>bc', -- 块注释切换
      },
      opleader = {
        line = '<leader>c',
        block = '<leader>b',
      }
    })
  end
}

