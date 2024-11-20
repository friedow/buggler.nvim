# buggler.nvim

Toggle neovim terminal buffers with a single keystroke.

## Installation

Plug

```
Plug 'friedow/buggler.nvim'
```

packer.nvim

```
use 'friedow/buggler.nvim'
```

## Usage

Just add a keybind and start toggling terminals.

```lua
vim.keymap.set("n", "<C-1>", function()
	require("buggler").toggle_terminal_buffer("Terminal 1")
end)

vim.keymap.set("n", "<C-2>", function()
	require("buggler").toggle_terminal_buffer("Terminal 2")
end)
```
