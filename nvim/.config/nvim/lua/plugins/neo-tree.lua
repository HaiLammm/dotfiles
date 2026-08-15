return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		-- cố ý không gọi setup(): dùng nguyên cấu hình mặc định của neo-tree,
		-- chỉ đặt keymap mở/đóng cây file
		-- key map for neo tree
		vim.keymap.set("n", "<leader>v", ":Neotree filesystem reveal left<CR>", {})
		vim.keymap.set("n", "<leader>xx", ":Neotree filesystem close <CR>", {})
	end,
}
