return {
    -- 主题插件
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        lazy = false,
        config = function()
            vim.cmd.colorscheme("tokyonight-moon")
        end
    },
    {
        "nvim-lualine/lualine.nvim", -- 轻量状态栏
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "tokyonight",
                    section_separators = { left = "", right = "" }
                }
            })
        end
    },
    {
        "nvim-tree/nvim-web-devicons", -- 文件类型图标支持
        lazy = true,                   -- 按需加载
        config = function()
            require("nvim-web-devicons").setup()
        end
    },
    {
        "glepnir/dashboard-nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-telescope/telescope.nvim"
        },
        config = function()
            local db = require("dashboard")

            db.setup({
                theme = 'hyper',
                config = {
                    header = {
                        '',
                        '.xxxXxxxxXxXXxXxxXxxXxxXxXxxxXXxxXXXxX$&&&&X..::;xxxx$&&&&&$XXXXxxxxxxxxxxXXxXxXxXXXXxxxXxxXxxxxXxX.',
                        '.XXXXxXXxXXxxXXXXXxxXxxXxXXXXXxxxxXXX&&&..................+&&&XxxxXxxxxxxxxxxXXXXXxxXXxXXXXxxxxxxXx.',
                        '.xxxxxxXXXxXXxXxxXxxxXxXXXxxxxXXxxx&&&...:::::::::::::::;:...&&&$XxXXXxxxXXXXxxxxxXXxxXXxxXxXXXxxxx.',
                        '.xxxXxXxxXxXXxXxxXxxxXxXxxxxxxxxx$&&...:::::::::::::::::::;;...&&&$xxxxxxXxxXxxXxxXxxxXxxxxXXxxXxxx.',
                        '.xXxxxXxxXxxXXXXxxXXXxXxxxXXXXXx&&X..;:;::::::::::::::::::::;;...&&$XXxxXXxxXXxXxxXxXxXXXxxXXxxXxxx.',
                        '.XXXXXXXXXxxXxxxXXxxXxXxxxxXxxX&&........:;;::::::::::::::::::;;:.;&$xXXXxxxXxxxXXXXxxXxxxxXxXXxXXx.',
                        '.xxxxxxxxxxxXxxxXxxxxxXxxxxXxx&&..;.&&&&....:;:::::::::::::::::::...&$XxxXXXxxxxxXxxXxXxxxxXxXxxxxX.',
                        '.xXXXxxxxXxxXxXxxXXxxxXxxXXXx&&..:..&&&&&&&...:;:::::::::::::::::;:..&XXxXxxxxxxxXxxXxXxxXXXxxXXXXX.',
                        '.xxxXXXXXXxxXxXxxxxXXxXXXXxX$&..::.&&&&&&&&&&...:;::::::::::::::::::.&$xxxxXxXXXxxXxxxxXXxxXXxXxXxx.',
                        '.XxxxXXxxxxxxxXxxXXXxXXxxxX$&..;;..&&&&&&&+&&&&...:;;:;;::;;:::::::;.x&xXXxxXxxXxxXXXxxxXXxxxXxxxXx.',
                        '.XxxxxXxxXxxxxxxxxxxxxxxxxX&&.::;..&&&&&&&&&&&&&&...;:::;::;::::::::.;&xxxxxXxxxxXxxxXxxxxxxxXxXxxx.',
                        '.XXxXxXxxXxxxxxxxXXXXXXXXXx&.:;:;.&&&&&&&&&&&:..&&&.+::;::..:;;;;;:;..&XXxxxxXXXXXxXXxxxXXxxXxxxxxx.',
                        '.xxxxxxXxxxxxxxxxxxxxxxXXxx&.::::.&&.&&&&&&&&&&&....x.;:;:;:;:.::;:;..&xXxxxxxXxxxxxxxxxxxXXxxxxxxx.',
                        '.XxxxxxxxxxxxxxxxxxXXXXxxXx&;.;;..&....&&&&&&&&&x&&...:..:::::;;..:;:.&xXxXXxxXxxXXXXXXXXXxxxxxxxxx.',
                        '.xxxxxxxxxxxxxxxxxxxxxXXXxx&&.;:.&&.&&&..&&&&&&&&&&&&&.....:::.;;;.:+.&xXxxxxxXxxXxXxxXxxxxxxxxxxxx.',
                        '.xxxxxxxxxxxxxxxxXXXXxXxxxXX&.x:.&&:......&&&&&&&&&&&.&&&&...::::;;:x.&$XxXXxxxXXXxXxxXxXXXxxxxxxxx.',
                        '.xxxxxxxxxxxxxxxxXxxxXXxxxxX&.;..&&&.X&&.&&&&&&&&&&&&&&&&&&...;;;::.;.&&XxxxxxxxxxXXXXxxxxxxxxXXxxx.',
                        '.xxxxxxxxxxxxxxxxXxxxXxxxxxX&.;.&&&&&&&&&&&&&&&&&&&&&&&&&&&&&..;::::;.;&xXxxxxxxxxxxxxXXxxxxxxXxXxx.',
                        '.xxxxxxxxxxxxxxxxXXXxXXXXXXX&.+.&&&&&..&&&.&&&&&&&&&&&&&&&&&&&..+;;;;..&xxxxxxxxxxxXXxxxXXXXXxXxXxx.',
                        '.xxxxxxxxxxxxxxxxxxxxxxxxXX$&.+.&&&&&.&&&&&&&&&&&&.&&&&&&&&:&...;:::...&XXxxxxxxxxxxxXXXxxxxxxxXxxx.',
                        '.xxxxxxxxxxxxxxxxxXxxxXXXxx&..;..&&&..&&&&&&&&.X&&&&&&&&&&$...:;;:...$&&XxxxxxxxxxxxxxxXXXXXXXXXXXx.',
                        '.xxxxxxxxxxxxxxxxxxxXxxxxXx&&....&......&&&&&&&&&&&&&&&&&...;xx+..:&&&$xxxxxxxxxxxxxxxXxxxXxxxxxxxX.',
                        '.xxxxxxxxxxxxxxxxxxxxxxxxxXX&&&.....;;;...&&&&&&&&&&&&&...;xx;..$&&&XXXXxxxxxxxxxxxxxxXxXx$$XxXXxxX.',
                        '.xxxxxxXXXXXxxxxxxxxxxxxXXXXxx&&&&.....+:...&&&&&&&&&...++;..xx:...&xxxxxxxXXXXXXXXXXX&&&&&&&&&&&&&.',
                        '.xxxxxxXxxxXxxxxxxxxxxxxXxxXxXXX$&&&&x....x...;&&&....xx..xx..+::;.&XxxxxxxxxxxX&&&xx&&.............',
                        '.xxxxxxXxxxxxxxxxxxxxxXXXxxXxxxxxXx&&&$x:.:..;.....;+;.:x;.;+;;::x.&&XXXXxxXXx&&&.&&&&........:&&&&.',
                        '.xxxXXXxXXXXXxXXXXxXXXX$&&&&&&XX$&&&;..:+x.x:..;Xxx.:x;.:x;+;;;;;x..&&&xxXXX&&&....&&......&&&&&xxX.',
                        '.xxxXxxXxXxxXxxx&&&&&&&&:....&&&&&...;::;;x;+........:+;+;:::;;;..;;..&&Xxx&&............&&&$XXxxXX.',
                        '.xxxXxxxxXxxX&&&&....&&..;+;.....;.+:;:.;.;;++xx++x;;;::::::....::::+..&Xxx&.........x&&&&$XxXXxxXx.',
                        '.xxxxXXxxxX&&&...:;;:...;;;;;.&$&&..;;;.;;;..:;;;;;;;;;;;::;;;;;xxx.:.&&&x.x&&&&&&&&&&&XxxxxxxxXXxX.',
                        '.xxxxxxxxX$&...;;;;;;:;;;;;:;.$$;:;..;;;.;;:+;;;;:::..::::;;;;;;...:&$...&&&x&&$$$XXXXXXXXXXXxxxxxx.',
                        '.xxxxxxxxX&x.;++;;;;:.;;:;+;.$$..;.$.+;;.;::;:....::;::;;+++...:$.x&..:&&;&&..&&&&$xxxxxxxxxxxxxxXx.',
                        '',
                    },
                }
            })
        end
    }
}
