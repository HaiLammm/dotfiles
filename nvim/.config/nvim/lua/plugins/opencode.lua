return {
    "NickvanDyke/opencode.nvim",
    dependencies = {
        -- Bắt buộc cho input, picker, terminal
        {
            "folke/snacks.nvim",
            opts = {
                input = { enabled = true },
                picker = { enabled = true },
                terminal = { enabled = true },
            },
        },
    },
    event = "VeryLazy",
    config = function()
        -- Config tùy chọn (từ docs GitHub)
        vim.g.opencode_opts = vim.g.opencode_opts or {}

        -- Bắt buộc cho reload buffer khi OpenCode edit file (Next.js/Python)
        vim.o.autoread = true

        local op = require("opencode")

        -- Keymap <C-a>: Hỏi OpenCode về code hiện tại (normal/visual mode)
        vim.keymap.set({ "n", "x" }, "<C-a>", function()
            op.ask("@this:", { submit = true })
        end, { desc = "Ask OpenCode about current code" })

        -- Keymap <C-x>: Menu chọn action (explain, review, fix...)
        vim.keymap.set({ "n", "x" }, "<C-x>", op.select, { desc = "OpenCode actions menu" })

        -- Keymap ga: Add code vào prompt OpenCode
        vim.keymap.set({ "n", "x" }, "ga", function()
            op.prompt("@this")
        end, { desc = "Add code to OpenCode prompt" })

        -- Keymap <C-.>: Toggle terminal OpenCode
        vim.keymap.set({ "n", "t" }, "<C-.>", op.toggle, { desc = "Toggle OpenCode terminal" })

        -- Cuộn terminal OpenCode (half page up/down)
        vim.keymap.set("n", "<S-C-u>", function()
            op.command("session.half.page.up")
        end, { desc = "OpenCode half page up" })
        vim.keymap.set("n", "<S-C-d>", function()
            op.command("session.half.page.down")
        end, { desc = "OpenCode half page down" })
    end,
}
