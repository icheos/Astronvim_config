local utils = require "astronvim.utils"
local is_available = utils.is_available
local ui = require "astronvim.utils.ui"

local maps = { i = {}, n = {}, v = {}, t = {},[""] = {} }

local sections = {
  f = { desc = "󰍉 Find" },
  p = { desc = "󰏖 Packages" },
  l = { desc = " LSP" },
  u = { desc = " UI" },
  b = { desc = "󰓩 Buffers" },
  d = { desc = " Debugger" },
  g = { desc = " Git" },
  S = { desc = "󱂬 Session" },
  t = { desc = " Terminal" },
}

local opt = {
  noremap = true,
  silent = true,
}

local map = vim.api.nvim_set_keymap

maps[""]["<Space>"] = "<Nop>"

if not vim.g.icons_enabled then vim.tbl_map(function(opts) opts.desc = opts.desc:gsub("^.* ", "") end, sections) end

-- Normal --
-- Standard Operations
maps.n["<leader>q"] = { "<cmd>q<cr>", desc = "Quit" }
maps.n["gx"] = { utils.system_open, desc = "Open the file under cursor with system app" }
maps.n["Q"] = "<Nop>"

maps.n["s"] = "<Nop>"
-- 上下比例
map("n", "sj", ":resize +10<CR>", opt)
map("n", "sk", ":resize -10<CR>", opt)
map("n", "<C-Down>", ":resize +2<CR>", opt)
map("n", "<C-Up>", ":resize -2<CR>", opt)
-- 相等比例
map("n", "s=", "<C-w>=", opt)
-- Terminal
map("n", "st", ":sp | terminal<CR>", opt)
map("n", "stv", ":vsp | terminal<CR>", opt)
-- terminal比例
map("t", "<Esc>", "<C-\\><C-n>", opt)

-- Manage Buffers
maps.n["<leader>C"] = { function() require("astronvim.utils.buffer").close() end, desc = "Close buffer" }
maps.n["<leader>c"] = { function() require("astronvim.utils.buffer").close(0, true) end, desc = "Force close buffer" }

if is_available "bufferline.nvim" then
  maps.n["<S-l>"] = { "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer tab" }
  maps.n["<S-h>"] = { "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer tab" }
else
  maps.n["<S-l>"] = { "<cmd>bnext<cr>", desc = "Next buffer" }
  maps.n["<S-h>"] = { "<cmd>bprevious<cr>", desc = "Previous buffer" }
end


-- NeoTree
if is_available "neo-tree.nvim" then
  map("n", "<A-m>", ":Neotree toggle<CR>", opt)
end

-- Session Manager

-- Package Manager

-- LSP Installer


-- SymbolsOutline
if is_available "aerial.nvim" then
  maps.n["<leader>a"] = { function() require("aerial").toggle() end, desc = "Symbols outline" }
end

-- Telescope

-- Terminal
if is_available "toggleterm.nvim" then
  maps.n["<F7>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" }
  --maps.n["<C-m>"] = maps.n["<F7>"]
end

-- Tex
maps.n["<leader>tl"] = { "<cmd>VimtexCompile<cr>", desc = "VimtexCompile" }
maps.n["<leader>tv"] = { "<cmd>VimtexView<cr>", desc = "VimtexView" }


-- debugger

-- Stay in indent mode
maps.v["<"] = { "<gv", desc = "unindent line" }
maps.v[">"] = { ">gv", desc = "indent line" }

-- Improved Terminal Navigation
--
-- Custom menu for modification of the user experience

utils.set_mappings(astronvim.user_opts("mappings", maps))
