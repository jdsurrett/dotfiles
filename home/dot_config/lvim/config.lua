-- luacheck: globals vim lvim
-- {{{ User Config
lvim.log.level = "warn"
lvim.format_on_save = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.foldmethod = "marker"
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.cursorcolumn = true
vim.opt.ruler = true
lvim.builtin.notify.active = true
lvim.builtin.dap.active = true

-- }}}
-- {{{ Colorscheme
vim.g.tokyonight_style = "night"
vim.g.tokyonight_hide_inactive_statusline = true
vim.g.tokyonight_colors = {comment = "yellow"}
vim.g.tokyonight_transparent = true
vim.g.tokyonight_transparentSidebar = true
lvim.colorscheme = "tokyonight"
lvim.transparent_window = true

-- }}}
-- {{{ Terminal
lvim.builtin.terminal.active = true
lvim.builtin.terminal.direction = 'float'

-- }}}
-- {{{ Alpha
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
-- lvim.builtin.alpha.dashboard.config = {vim.api.nvim_exec(":MinimapClose", true)}

-- }}}
-- {{{ Lualine
local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.options.theme = "tokyonight"
lvim.builtin.lualine.sections.lualine_a = {'mode'}
lvim.builtin.lualine.sections.lualine_b = {components.filename}
lvim.builtin.lualine.sections.lualine_c = {'branch', 'diff'}
lvim.builtin.lualine.sections.lualine_x = {'diagnostics'}
lvim.builtin.lualine.sections.lualine_y = {
    components.treesitter, components.lsp, 'filetype'
}
lvim.builtin.lualine.sections.lualine_z = {
    components.location, components.scrollbar
}
lvim.builtin.lualine.options.section_separators = {left = '', right = ''}
lvim.builtin.lualine.options.component_separators = {
    left = '┊',
    right = '┊'
}

-- }}}
-- {{{ Nvimtree
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
-- }}}
-- {{{ Treesitter
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.treesitter.rainbow.extended_mode = true
lvim.builtin.treesitter.rainbow.max_file_lines = 1000
-- }}}
-- {{{ Bufferline
lvim.builtin.bufferline.options.indicator_icon = "┊"
lvim.builtin.bufferline.options.separator_style = {'┊', '┊'}
-- }}}
-- {{{ Keymappings
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-q>"] = ":qa!<cr>"
lvim.builtin.which_key.mappings["P"] = {
    "<cmd>Telescope projects<CR>", "Projects"
}
lvim.builtin.which_key.mappings["S"] = {
    name = "Session",
    c = {
        "<cmd>lua require('persistence').load()<cr>",
        "Restore last session for current dir"
    },
    l = {
        "<cmd>lua require('persistence').load({ last = true })<cr>",
        "Restore last session"
    },
    Q = {
        "<cmd>lua require('persistence').stop()<cr>",
        "Quit without saving session"
    }
}

-- }}}
-- {{{ LSP settings
lvim.builtin.treesitter.ensure_installed = {
    "bash", "c", "cpp", "javascript", "json", "lua", "typescript", "css", "nix",
    "make", "cmake", "toml", "rust", "yaml"
    -- ,"zsh","python","tsx",
}
lvim.builtin.treesitter.ignore_install = {"java", "haskell"}
lvim.builtin.treesitter.highlight.enabled = true
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    {command = "lua-format", filetypes = {"lua"}}
    --
}
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    {command = "luacheck", filetypes = {"lua"}}
    --
}
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers,
--                 {"rust_analyzer"})

-- }}}
-- {{{ Additional Plugins
lvim.plugins = {
    -- {{{ Colorschemes
    {"folke/tokyonight.nvim"}, -- }}}
    -- {{{ Rust
    -- {{{Rust tools
    {
        "simrat39/rust-tools.nvim",
        config = function()
            local lsp_installer_servers = require "nvim-lsp-installer.servers"
            local _, requested_server =
                lsp_installer_servers.get_server "rust_analyzer"
            require("rust-tools").setup({
                tools = {
                    autoSetHints = true,
                    hover_with_actions = true,
                    runnables = {use_telescope = true}
                },
                server = {
                    cmd_env = requested_server._default_options.cmd_env,
                    on_attach = require("lvim.lsp").common_on_attach,
                    on_init = require("lvim.lsp").common_on_init
                }
            })
        end,
        ft = {"rust", "rs"}
    }, -- }}}
    -- {{{ Crates nvim
    -- {{{ Top
    {
        'saecki/crates.nvim',
        tag = 'v0.1.0',
        requires = {'nvim-lua/plenary.nvim'},
        config = function()
            require('crates').setup {
                smart_insert = true,
                avoid_prerelease = true,
                autoload = true,
                autoupdate = true,
                loading_indicator = true,
                date_format = "%Y-%m-%d",
                text = {
                    loading = "   Loading",
                    version = "   %s",
                    prerelease = "   %s",
                    yanked = "   %s",
                    nomatch = "   No match",
                    upgrade = "   %s",
                    error = "   Error fetching crate"
                },
                highlight = {
                    loading = "CratesNvimLoading",
                    version = "CratesNvimVersion",
                    prerelease = "CratesNvimPreRelease",
                    yanked = "CratesNvimYanked",
                    nomatch = "CratesNvimNoMatch",
                    upgrade = "CratesNvimUpgrade",
                    error = "CratesNvimError"
                },
                popup = {
                    autofocus = false,
                    copy_register = '"',
                    style = "minimal",
                    border = "none",
                    version_date = false,
                    max_height = 30,
                    min_width = 20,
                    text = {
                        title = "  %s ",
                        version = "   %s ",
                        prerelease = "  %s ",
                        yanked = "  %s ",
                        date = " %s ",
                        feature = "   %s ",
                        enabled = "  %s ",
                        transitive = "  %s "
                    },
                    -- }}}
                    -- {{{ Bottom
                    highlight = {
                        title = "CratesNvimPopupTitle",
                        version = "CratesNvimPopupVersion",
                        prerelease = "CratesNvimPopupPreRelease",
                        yanked = "CratesNvimPopupYanked",
                        feature = "CratesNvimPopupFeature",
                        enabled = "CratesNvimPopupEnabled",
                        transitive = "CratesNvimPopupTransitive"
                    },
                    keys = {
                        hide = {"q", "<esc>"},
                        select = {"<cr>"},
                        select_alt = {"s"},
                        copy_version = {"yy"},
                        toggle_feature = {"<cr>"},
                        goto_feature = {"gd", "K"},
                        jump_forward_feature = {"<c-i>"},
                        jump_back_feature = {"<c-o>"}
                    }
                },
                cmp = {
                    -- insert_closing_quote = true,
                    text = {
                        prerelease = "  pre-release ",
                        yanked = "  yanked "
                    }
                }
            }
        end
    }, -- }}} }}} }}}
    -- {{{ AutoSave
    {
        "Pocco81/AutoSave.nvim",
        config = function()
            require("autosave").setup({
                execution_message = "AutoSave: saved at " ..
                    vim.fn.strftime("%I:%M %p ┊ %D"),
                events = {"InsertLeave", "TextChanged"},
                conditions = {
                    exists = true,
                    filename_is_not = {"config.lua"},
                    filetype_is_not = {},
                    modifiable = true
                },
                write_all_buffers = true,
                on_off_commands = true,
                clean_command_line_interval = 0,
                debounce_delay = 135
            })
        end
    }, -- }}}
    -- {{{ Minimap
    {
        'wfxr/minimap.vim',
        run = "cargo install --locked code-minimap",
        -- cmd = {"Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight"},
        config = function()
            vim.cmd("let g:minimap_width = 15")
            vim.cmd("let g:minimap_auto_start = 1")
            vim.cmd("let g:minimap_auto_start_win_enter = 1")
            vim.cmd("let g:minimap_close_buftypes = ['terminal','nvim-tree']")
            vim.cmd("let g:minimap_highlight_range = 1")
            vim.cmd("let g:minimap_highlight_search = 1")
            vim.cmd("let g:minimap_git_colors = 1")
        end
    }, -- }}}
    -- -- {{{ Glow
    -- { "npxbr/glow.nvim", ft = { "markdown" }, run = "yay -S glow" }, -- }}}
    -- {{{ Vim Kitty Navigator
    {"knubie/vim-kitty-navigator", run = "cp ./*.py ~/.config/kitty/"}, -- }}}
    -- {{{ Neoscroll
    {
        "karb94/neoscroll.nvim",
        event = "WinScrolled",
        config = function()
            require('neoscroll').setup({
                hide_cursor = true, -- Hide cursor while scrolling
                stop_eof = true, -- Stop at <EOF> when scrolling downwards
                use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
                respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
                cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
                easing_function = nil, -- Default easing function
                pre_hook = nil, -- Function to run before the scrolling animation starts
                post_hook = nil -- Function to run after the scrolling animation ends
            })
            local t = {}
            -- Syntax: t[keys] = {function, {function arguments}}
            t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '250'}}
            t['<C-d>'] = {'scroll', {'vim.wo.scroll', 'true', '250'}}
            t['<C-b>'] = {
                'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '450'}
            }
            t['<C-f>'] = {
                'scroll', {'vim.api.nvim_win_get_height(0)', 'true', '450'}
            }
            t['<C-y>'] = {'scroll', {'-0.10', 'false', '100'}}
            t['<C-e>'] = {'scroll', {'0.10', 'false', '100'}}
            t['zt'] = {'zt', {'250'}}
            t['zz'] = {'zz', {'250'}}
            t['zb'] = {'zb', {'250'}}
            require('neoscroll.config').set_mappings(t)
        end
    }, -- }}}
    -- {{{ Todo-comments
    {
        "folke/todo-comments.nvim",
        event = "BufRead",
        config = function() require("todo-comments").setup() end
    }, -- }}}
    -- {{{ Vim-surround
    {"tpope/vim-surround", keys = {"c", "d", "y"}}, -- }}}
    -- {{{ Persistence
    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        module = "persistence",
        config = function()
            require("persistence").setup {
                dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"),
                options = {"buffers", "curdir", "tabpages", "winsize"}
            }
        end
    }, -- }}}
    -- {{{ Lastplace
    {
        "ethanholz/nvim-lastplace",
        event = "BufRead",
        config = function()
            require("nvim-lastplace").setup({
                lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
                lastplace_ignore_filetype = {
                    "gitcommit", "gitrebase", "svn", "hgcommit"
                },
                lastplace_open_folds = true
            })
        end
    }, -- }}}
    -- {{{ Neuron
    {"oberblastmeister/neuron.nvim"}, -- }}}
    -- --{{{ Trouble
    --     {
    --       "folke/trouble.nvim",
    --       cmd = "TroubleToggle",
    --     },
    -- --}}}
    -- {{{ Vim fugitive
    {
        "tpope/vim-fugitive",
        cmd = {
            "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove",
            "GDelete", "GBrowse", "GRemove", "GRename", "Glgrep", "Gedit"
        },
        ft = {"fugitive"}
    }, -- }}}
    -- {{{ Nvim ts-rainbow
    {"p00f/nvim-ts-rainbow"}, -- }}}
    -- {{{ Vim cursorword
    {
        "itchyny/vim-cursorword",
        event = {"BufEnter", "BufNewFile"},
        config = function()
            vim.api.nvim_command("augroup user_plugin_cursorword")
            vim.api.nvim_command("autocmd!")
            vim.api.nvim_command(
                "autocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0")
            vim.api.nvim_command(
                "autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif")
            vim.api.nvim_command("autocmd InsertEnter * let b:cursorword = 0")
            vim.api.nvim_command("autocmd InsertLeave * let b:cursorword = 1")
            vim.api.nvim_command("augroup END")
        end
    }
} -- }}} }}}
-- {{{ Autocommands
lvim.autocommands.custom_groups = {
    {"User,BufEnter", "*", ":lua vim.wo.fillchars = 'vert:║,fold:.,eob: '"},
    {"TermEnter,QuitPre", "*", ":MinimapClose"},
    {"BufEnter", "*", ":MinimapRefresh"}
}
-- }}}
