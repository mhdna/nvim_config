-- local lsp_filetypes =
-- { "go", "html", "css", "php", "blade", "json", "javascript", "typescript", "python", "bash", "sh" }
return {
	"jay-babu/mason-null-ls.nvim",
	-- event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	enabled = false,
	-- ft = lsp_filetypes,
	config = function()
		require("mason-null-ls").setup({
			ensure_installed = {
				"stylua",
				"jq",
				"markdownlint",
				"proselint",
				"hadolint",
				-- { 'bash-language-server', auto_update = true },
				-- "flake8",
				"prettierd", -- prettier formatter
				"stylua", -- lua formatter
				-- "isort", -- python formatter
				-- "black", -- python formatter
				-- "pylint", -- python linter
				"dictionary",
				"ruff-lsp",
				"mypy",
				-- "ruff", -- python linter
				-- "eslint_d", -- js linter
				"shellcheck",
				"editorconfig-checker",
				"impl",
				"json-to-struct",
				"luacheck",
				"misspell",
				"revive",
				"shfmt",
				"staticcheck",
				"clangd",
				"clang-format",
				-- "solidity",
				-- "solidity_ls_nomicfoundation",
				"pylsp",
				"lua_ls",
				"dockerls",
				-- "emmet_ls",
				-- "eslint",
				"html",
				"cssls",
				-- "csharp_ls",
				-- "xmlformatter",
				-- "typos",
				-- "astro",
				"bashls",
				-- "fish_lsp",
				-- "gradle_ls",
				-- "helm_ls",
				-- "jedi_language_server",
				"jqls",
				"lemminx",
				"marksman",
				-- "ocamllsp",
				"prosemd_lsp",
				"quick_lint_js",
				"somesass_ls",
				"terraformls",
				-- "texlab",
				"vale_ls",
				"vimls",
				"cssls",
				-- "denols",
				-- "eslint",
				"glint",
				"html",
				-- "jsonls",
				-- "kotlin_language_server",
				"lua_ls",
				-- "powershell_es",
				-- "rust-analyzer",
				"stylelint-lsp",
				-- "svelte",
				"tailwindcss",
				-- "typescript-tools",
				-- "typos_lsp",
				"volar",
				"markdown-toc",
				"json-lsp",
				"docker-compose-language-service",
				"vtsls",

				"taplo",
				"pyright",
				"yamlls",
				-- go
				"gopls",
				-- "shellharden", -- stupid and useless
				"golangci-lint",
				"gofumpt",
				"gofmt",
				"goimports",
				"golines",
				"gomodifytags",
				"gotests",
				-- php
				-- "phpstan",
				"intelephense",
				"php-cs-fixer",
				"blade-formatter",
				"phpcs",
				"phpactor",
			},
		})
	end,
}
