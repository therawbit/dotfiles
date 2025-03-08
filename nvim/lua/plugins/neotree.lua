return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		local keymap = vim.keymap -- for conciseness
		local neotree = require("neo-tree")
		neotree.setup({
			window = {
				position = "left",
				width = 30,
				mappings = {
					["P"] = "toggle_preview",
					["<C-b>"] = "toggle",
				},
			},
		})
		keymap.set("n", "<C-b>", "<Cmd>Neotree toggle<CR>", { noremap = true, silent = true })
	end,
}
