local _MODULE = {}
local CORE_WORD_CHARS = {
	_ = true,
}
for byte = string.byte("0"), string.byte("9") do
	CORE_WORD_CHARS[string.char(byte)] = true
end
for byte = string.byte("a"), string.byte("z") do
	CORE_WORD_CHARS[string.char(byte)] = true
end
for byte = string.byte("A"), string.byte("Z") do
	CORE_WORD_CHARS[string.char(byte)] = true
end
local function get_word_chars()
	local word_chars = {}
	for core_word_char in pairs(CORE_WORD_CHARS) do
		word_chars[core_word_char] = true
	end
	for i = 1, #vim.g.emacs_bindings_wordchars do
		word_chars[vim.g.emacs_bindings_wordchars:sub(i, i)] = true
	end
	return word_chars
end
local function feed_term_codes(term_codes)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(term_codes, true, false, true), "n", false)
end
local function get_word_back_col(line, col)
	local word_chars = get_word_chars()
	local next_char = line:sub(col - 1, col - 1)
	while col > 1 and not word_chars[next_char] do
		col = col - 1
		next_char = line:sub(col - 1, col - 1)
	end
	while col > 1 and word_chars[next_char] do
		col = col - 1
		next_char = line:sub(col - 1, col - 1)
	end
	return col
end
local function get_move_word_forward_col(line, col)
	local word_chars = get_word_chars()
	local next_char = line:sub(col + 1, col + 1)
	while col < #line and word_chars[next_char] do
		col = col + 1
		next_char = line:sub(col + 1, col + 1)
	end
	while col < #line and not word_chars[next_char] do
		col = col + 1
		next_char = line:sub(col + 1, col + 1)
	end
	return col + 1
end
local function get_delete_word_forward_col(line, col)
	local word_chars = get_word_chars()
	local next_char = line:sub(col + 1, col + 1)
	while col < #line and not word_chars[next_char] do
		col = col + 1
		next_char = line:sub(col + 1, col + 1)
	end
	while col < #line and word_chars[next_char] do
		col = col + 1
		next_char = line:sub(col + 1, col + 1)
	end
	return col + 1
end
local function move_word_back()
	if vim.fn.mode() == "c" then
		local col = vim.fn.getcmdpos()
		local line = vim.fn.getcmdline()
		feed_term_codes(("<Left>"):rep(col - get_word_back_col(line, col)))
	else
		local _, lnum, col
		do
			local __ERDE_TMP_126__
			__ERDE_TMP_126__ = vim.fn.getpos(".")
			_ = __ERDE_TMP_126__[1]
			lnum = __ERDE_TMP_126__[2]
			col = __ERDE_TMP_126__[3]
		end
		local line = vim.fn.getline(".")
		vim.fn.setcharpos(".", {
			0,
			lnum,
			get_word_back_col(line, col),
			0,
		})
	end
end
_MODULE.move_word_back = move_word_back
local function move_word_forward()
	if vim.fn.mode() == "c" then
		local col = vim.fn.getcmdpos()
		local line = vim.fn.getcmdline()
		feed_term_codes(("<Right>"):rep(get_move_word_forward_col(line, col) - col))
	else
		local _, lnum, col
		do
			local __ERDE_TMP_148__
			__ERDE_TMP_148__ = vim.fn.getpos(".")
			_ = __ERDE_TMP_148__[1]
			lnum = __ERDE_TMP_148__[2]
			col = __ERDE_TMP_148__[3]
		end
		local line = vim.fn.getline(".")
		vim.fn.setcharpos(".", {
			0,
			lnum,
			get_move_word_forward_col(line, col),
			0,
		})
	end
end
_MODULE.move_word_forward = move_word_forward
local function delete_char_back()
	local _, _, col
	do
		local __ERDE_TMP_159__
		__ERDE_TMP_159__ = vim.fn.getpos(".")
		_ = __ERDE_TMP_159__[1]
		_ = __ERDE_TMP_159__[2]
		col = __ERDE_TMP_159__[3]
	end
	if vim.fn.mode() == "c" or col > 1 then
		feed_term_codes("<BS>")
	end
end
_MODULE.delete_char_back = delete_char_back
local function delete_char_forward()
	local _, _, col
	do
		local __ERDE_TMP_167__
		__ERDE_TMP_167__ = vim.fn.getpos(".")
		_ = __ERDE_TMP_167__[1]
		_ = __ERDE_TMP_167__[2]
		col = __ERDE_TMP_167__[3]
	end
	local line = vim.fn.getline(".")
	if vim.fn.mode() == "c" or col <= #line then
		feed_term_codes("<Delete>")
	end
end
_MODULE.delete_char_forward = delete_char_forward
local function delete_word_back()
	if vim.fn.mode() == "c" then
		local col = vim.fn.getcmdpos()
		local line = vim.fn.getcmdline()
		feed_term_codes(("<BS>"):rep(col - get_word_back_col(line, col)))
	else
		local _, lnum, col
		do
			local __ERDE_TMP_189__
			__ERDE_TMP_189__ = vim.fn.getpos(".")
			_ = __ERDE_TMP_189__[1]
			lnum = __ERDE_TMP_189__[2]
			col = __ERDE_TMP_189__[3]
		end
		local line = vim.fn.getline(".")
		local new_col = get_word_back_col(line, col)
		vim.fn.setline(lnum, line:sub(1, new_col - 1) .. line:sub(col))
		vim.fn.setcharpos(".", {
			0,
			lnum,
			new_col,
			0,
		})
	end
end
_MODULE.delete_word_back = delete_word_back
local function delete_word_forward()
	if vim.fn.mode() == "c" then
		local col = vim.fn.getcmdpos()
		local line = vim.fn.getcmdline()
		feed_term_codes(("<Delete>"):rep(get_delete_word_forward_col(line, col) - col))
	else
		local _, lnum, col
		do
			local __ERDE_TMP_218__
			__ERDE_TMP_218__ = vim.fn.getpos(".")
			_ = __ERDE_TMP_218__[1]
			lnum = __ERDE_TMP_218__[2]
			col = __ERDE_TMP_218__[3]
		end
		local line = vim.fn.getline(".")
		local new_col = get_delete_word_forward_col(line, col)
		vim.fn.setline(lnum, line:sub(1, col - 1) .. line:sub(new_col))
	end
end
_MODULE.delete_word_forward = delete_word_forward
local function delete_line_back()
	if vim.fn.mode() == "c" then
		feed_term_codes(("<BS>"):rep(vim.fn.getcmdpos()))
	else
		local _, lnum, col
		do
			local __ERDE_TMP_238__
			__ERDE_TMP_238__ = vim.fn.getpos(".")
			_ = __ERDE_TMP_238__[1]
			lnum = __ERDE_TMP_238__[2]
			col = __ERDE_TMP_238__[3]
		end
		local line = vim.fn.getline(".")
		vim.fn.setline(lnum, line:sub(col))
		vim.fn.setcharpos(".", {
			0,
			lnum,
			1,
			0,
		})
	end
end
_MODULE.delete_line_back = delete_line_back
local function delete_line_forward()
	if vim.fn.mode() == "c" then
		local col = vim.fn.getcmdpos()
		local line = vim.fn.getcmdline()
		feed_term_codes(("<Delete>"):rep(#line - col + 1))
	else
		local _, lnum, col
		do
			local __ERDE_TMP_259__
			__ERDE_TMP_259__ = vim.fn.getpos(".")
			_ = __ERDE_TMP_259__[1]
			lnum = __ERDE_TMP_259__[2]
			col = __ERDE_TMP_259__[3]
		end
		local line = vim.fn.getline(".")
		vim.fn.setline(lnum, line:sub(1, col - 1))
	end
end
_MODULE.delete_line_forward = delete_line_forward
return _MODULE
-- Compiled with Erde 0.6.0-1
-- __ERDE_COMPILED__
