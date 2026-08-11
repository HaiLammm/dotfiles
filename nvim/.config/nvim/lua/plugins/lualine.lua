return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local function short_filename()
            local root = vim.fn.getcwd()
            local filepath = vim.fn.expand("%:p")
            if not filepath:find(root, 1, true) then
                return vim.fn.expand("%:t")
            end

            local relpath = filepath:sub(#root + 2)
            local parts = vim.split(relpath, "/")
            local len = #parts
            if len > 2 then
                return table.concat({ parts[len - 2], parts[len - 1], parts[len] }, "/")
            else
                return relpath
            end
        end
        -- Bảng màu amber-crt, khớp colors/amber-crt.lua, .tmux.conf và terminal
        local c = {
            bg = "#352b2d",
            bg_alt = "#46393c",
            sel = "#665356",
            dim = "#8a7a6a",
            fg = "#e8c89a",
            amber = "#ffb000",
            orange = "#e07b4a",
            olive_l = "#c4a85a",
            mauve_l = "#d99a9a",
            rust = "#c05a10",
        }
        local amber_crt = {
            normal = {
                a = { fg = c.bg, bg = c.amber, gui = "bold" },
                b = { fg = c.fg, bg = c.bg_alt },
                c = { fg = c.dim, bg = c.bg },
            },
            insert = { a = { fg = c.bg, bg = c.olive_l, gui = "bold" } },
            visual = { a = { fg = c.bg, bg = c.mauve_l, gui = "bold" } },
            replace = { a = { fg = c.bg, bg = c.rust, gui = "bold" } },
            command = { a = { fg = c.bg, bg = c.orange, gui = "bold" } },
            inactive = {
                a = { fg = c.dim, bg = c.bg_alt },
                b = { fg = c.dim, bg = c.bg_alt },
                c = { fg = c.sel, bg = c.bg },
            },
        }

        require("lualine").setup({
            options = {
                theme = amber_crt,
            },
            sections = {
                lualine_c = {
                    { short_filename },
                },
                lualine_z = {},
            },
        })
    end,
}
