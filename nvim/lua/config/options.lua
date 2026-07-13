vim.g.mapleader = ","
vim.g.maplocalleader = ","

local opt = vim.opt

opt.breakindent = true
opt.clipboard = "unnamedplus"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.hidden = true
opt.hlsearch = true
opt.ignorecase = true
opt.inccommand = "split"
opt.incsearch = true
opt.laststatus = 3
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.mouse = "a"
opt.number = true
opt.relativenumber = true
opt.scrolloff = 5
opt.shiftwidth = 2
opt.showmode = false
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.softtabstop = 2
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true
opt.updatetime = 250
opt.wrap = false

if vim.g.neovide then
  vim.o.guifont = "MesloLGS Nerd Font:h15"
  vim.g.neovide_cursor_animation_length = 0.08
  vim.g.neovide_scroll_animation_length = 0.15
end
