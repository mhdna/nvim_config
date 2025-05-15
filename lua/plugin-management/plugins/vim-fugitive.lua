return {
	"tpope/vim-fugitive",
	-- enabled = false,
	config = function()
		-- vim.keymap.set("n", "<M-g>", function()
		-- 	vim.cmd("Git diff --cached") -- show staged lines
		-- end)
		vim.keymap.set("n", "<M-P>", function()
			vim.cmd("Git push -u origin master") -- show staged lines
		end)
		vim.keymap.set("n", "<M-g>", function()
			vim.cmd("Git commit")
		end)
	end,
}
