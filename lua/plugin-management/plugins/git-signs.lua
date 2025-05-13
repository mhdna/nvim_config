return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "<M-j>", function()
					if vim.wo.diff then
						vim.cmd.normal({ "<M-j>", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end)

				map("n", "<M-k>", function()
					if vim.wo.diff then
						vim.cmd.normal({ "<M-k>", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end)

				-- Actions
				map("n", "<M-h>", gitsigns.select_hunk)
				map("n", "<M-s>", gitsigns.stage_hunk)
				map("n", "<M-S>", gitsigns.stage_buffer)
				map("n", "<M-R>", gitsigns.reset_buffer)
				map("n", "<M-r>", gitsigns.reset_hunk)
				map("n", "<M-u>", gitsigns.undo_stage_hunk)
				map("n", "<M-U>", gitsigns.reset_buffer_index)
				-- map("n", "<M-s>", function()
				-- 	gitsigns.stage_hunk()
				-- 	gitsigns.nav_hunk("next")
				-- end)
				map("n", "gr", gitsigns.reset_hunk)

				map("v", "gs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)

				map("v", "gr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)

				map("n", "gS", gitsigns.stage_buffer)
				map("n", "gR", gitsigns.reset_buffer)
				map("n", "<M-p>", gitsigns.preview_hunk)
				map("n", "<M-P>", gitsigns.preview_hunk_inline)

				map("n", "gb", function()
					gitsigns.blame_line({ full = true })
				end)

				map("n", "<M-G>", gitsigns.diffthis)

				-- map("n", "gD", function()
				-- 	gitsigns.diffthis("~")
				-- end)

				-- map("n", "<leader>hQ", function()
				-- 	gitsigns.setqflist("all")
				-- end)
				-- map("n", "<leader>hq", gitsigns.setqflist)

				-- Toggles
				-- map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
				-- map("n", "<leader>tw", gitsigns.toggle_word_diff)

				-- Text object
				-- map({ "o", "x" }, "ih", gitsigns.select_hunk)
			end,
		})
	end,
}
