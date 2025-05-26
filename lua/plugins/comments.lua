return {
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                toggler = {
                    line = '<leader>c',
                    block = '<leader>bc',
                },
                opleader = {
                    line = '<leader>c'
                    block = '<leader>b',
                }
            })
        end
    }
}
