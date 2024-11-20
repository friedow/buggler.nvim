--- Creates a new terminal buffer with the given name
---
--- @param name string Buffer name
local function create_terminal_buffer(name)
	vim.cmd.terminal()
	vim.api.nvim_buf_set_name(0, name)
	vim.cmd.startinsert()
end

--- Find a buffer given its name
---
--- @param name string buffer name to look for
--- @return integer|nil
local function find_buffer_by_name(name)
	local buffers = vim.api.nvim_list_bufs()
	for _, buffer in ipairs(buffers) do
		if vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buffer), ":t") == name then
			return buffer
		end
	end

	return nil
end

local M = {}

--- Toggles the given terminal buffer
---
--- @param name string terminal buffer name to toggle
function M.toggle_terminal_buffer(name)
	local current_buffer = vim.api.nvim_get_current_buf()

	-- If we are not in a terminal buffer we save the current
	-- buffer to the last visited non-terminal buffer variable
	if vim.api.nvim_get_option_value("buftype", { buf = current_buffer }) ~= "terminal" then
		M.last_non_terminal_buffer = vim.api.nvim_get_current_buf()
	end

	local terminal_buffer = find_buffer_by_name(name)

	if terminal_buffer == nil then
		create_terminal_buffer(name)
		return
	end

	-- If we are in the selected terminal buffer we switch
	-- back to the last visited non-terminal buffer
	if current_buffer == terminal_buffer then
		vim.api.nvim_set_current_buf(M.last_non_terminal_buffer)
		return
	end

	vim.api.nvim_set_current_buf(terminal_buffer)
	vim.cmd.startinsert()
end

return M
