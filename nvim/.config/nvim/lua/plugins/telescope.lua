return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		-- or                              , branch = '0.1.x',
		dependencies = { "nvim-lua/plenary.nvim" },
		file_ignore_patterns = { ".class" },
		-- keymaps tìm kiếm (<leader>ff/pf/fg/fb/fh) do fzf-lua đảm nhận,
		-- telescope chỉ giữ lại cho extension ui-select bên dưới
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				defaults = {
					layout_config = {
						horizontal = {
							preview_width = 0.6,
							width = 0.85,
						},
						vertical = {
							preview_height = 0.6,
							height = 0.85,
						},
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
