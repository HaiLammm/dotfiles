-- File: ~/.config/nvim/lua/plugins/copilot.lua

-- Copilot đòi Node 22+. nvm đang giữ v20 ở đầu PATH nên Copilot nhặt nhầm
-- bản cũ và tắt hẳn. Trỏ thẳng tới node của Homebrew, khỏi phải đổi node
-- mặc định của hệ thống (các dự án khác có thể vẫn cần v20).
local function copilot_node()
	for _, p in ipairs({
		"/home/linuxbrew/.linuxbrew/bin/node", -- Linux
		"/opt/homebrew/bin/node", -- macOS Apple Silicon
		"/usr/local/bin/node", -- macOS Intel
	}) do
		if vim.fn.executable(p) == 1 then
			return p
		end
	end
	return "node" -- không tìm thấy thì để Copilot tự dò trong PATH
end

return {
  -- Copilot chính
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        copilot_node_command = copilot_node(),
        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = true, -- Ẩn gợi ý mờ khi menu nvim-cmp đang mở để tránh rối mắt
          debounce = 75,
          keymap = {
            accept = "<M-l>",      -- Nhấn Alt + l để CHỌN NHANH toàn bộ gợi ý
            accept_word = "<M-w>", -- Nhấn Alt + w để chọn từng từ một
            accept_line = "<M-a>", -- Nhấn Alt + a để chọn từng dòng một
            next = "<M-]>",        -- Nhấn Alt + ] để xem gợi ý tiếp theo
            prev = "<M-[>",        -- Nhấn Alt + [ để xem gợi ý trước đó
            dismiss = "<C-]>",     -- Nhấn Ctrl + ] để bỏ qua gợi ý
          },
        },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
          yaml = true,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
          ["*"] = true, -- Bật cho tất cả các loại file khác
        },
      })
    end,
  },

  -- Tích hợp Copilot vào nvim-cmp
  {
    "zbirenbaum/copilot-cmp",
    dependencies = "zbirenbaum/copilot.lua",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
