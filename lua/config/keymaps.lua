-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Terminal docked on the right, 1/4 of the screen. <leader>tt toggles it.
local term = { buf = nil, win = nil }

local function toggle_right_terminal()
  if term.win and vim.api.nvim_win_is_valid(term.win) then
    vim.api.nvim_win_hide(term.win)
    term.win = nil
    return
  end

  vim.cmd("botright vsplit")
  term.win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_width(term.win, math.floor(vim.o.columns * 0.25))
  vim.wo[term.win].winfixwidth = true

  if term.buf and vim.api.nvim_buf_is_valid(term.buf) then
    vim.api.nvim_win_set_buf(term.win, term.buf)
  else
    vim.cmd("terminal")
    term.buf = vim.api.nvim_get_current_buf()
    vim.bo[term.buf].bufhidden = "hide"
  end
  vim.cmd("startinsert")
end

vim.keymap.set("n", "<leader>tt", toggle_right_terminal, { desc = "Toggle right terminal (25%)" })

-- Leave terminal mode / jump back to the code window from the terminal
vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Terminal normal mode" })
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "Go to left window" })
