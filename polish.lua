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
-- 取消 s 默认功能
map("n", "sv", ":vsp<CR>", opt)
map("n", "sh", ":sp<CR>", opt)
-- 关闭当前
map("n", "sc", "<C-w>c", opt)
-- 关闭其他
map("n", "so", "<C-w>o", opt) -- close others
-- alt + hjkl  窗口之间跳转
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)
-- <leader> + hjkl 窗口之间跳转
map("n", "<leader>h", "<C-w>h", opt)
map("n", "<leader>j", "<C-w>j", opt)
map("n", "<leader>k", "<C-w>k", opt)
map("n", "<leader>l", "<C-w>l", opt)
-- 左右比例控制
map("n", "<C-Left>", ":vertical resize -2<CR>", opt)
map("n", "<C-Right>", ":vertical resize +2<CR>", opt)
map("n", "s,", ":vertical resize -10<CR>", opt)
map("n", "s.", ":vertical resize +10<CR>", opt)
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
map("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opt)
map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)
map("t", "<leader>h", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "<leader>j", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "<leader>k", [[ <C-\><C-N><C-w>k ]], opt)
map("t", "<leader>l", [[ <C-\><C-N><C-w>l ]], opt)

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
if is_available "mason-lspconfig.nvim" then maps.n["<leader>li"] = { "<cmd>LspInfo<cr>", desc = "LSP information" } end

-- Smart Splits
if is_available "smart-splits.nvim" then
  -- Better window navigation
  maps.n["<A-h>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" }
  maps.n["<A-j>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" }
  maps.n["<A-k>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" }
  maps.n["<A-l>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" }

  -- Resize with arrows
  maps.n["<C-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" }
  maps.n["<C-Down>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" }
  maps.n["<C-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" }
  maps.n["<C-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" }
else
  maps.n["<A-h>"] = { "<C-w>h", desc = "Move to left split" }
  maps.n["<A-j>"] = { "<C-w>j", desc = "Move to below split" }
  maps.n["<A-k>"] = { "<C-w>k", desc = "Move to above split" }
  maps.n["<A-l>"] = { "<C-w>l", desc = "Move to right split" }
  maps.n["<C-Up>"] = { "<cmd>resize -2<CR>", desc = "Resize split up" }
  maps.n["<C-Down>"] = { "<cmd>resize +2<CR>", desc = "Resize split down" }
  maps.n["<C-Left>"] = { "<cmd>vertical resize -2<CR>", desc = "Resize split left" }
  maps.n["<C-Right>"] = { "<cmd>vertical resize +2<CR>", desc = "Resize split right" }
end

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
--maps.t["<C-h>"] = { "<c-\\><c-n><c-w>h", desc = "Terminal left window navigation" }
--maps.t["<C-j>"] = { "<c-\\><c-n><c-w>j", desc = "Terminal down window navigation" }
--maps.t["<C-k>"] = { "<c-\\><c-n><c-w>k", desc = "Terminal up window navigation" }
--maps.t["<C-l>"] = { "<c-\\><c-n><c-w>l", desc = "Terminal right window navigation" }

-- Custom menu for modification of the user experience

utils.set_mappings(astronvim.user_opts("mappings", maps))
