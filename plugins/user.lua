-- TODO: Test
--
--event opt
--
--User AstroFile: Triggered after opening file
--VeryLazy: Triggered after stating Neovim
--BufEnter *.lua: Triggered after opening a Lua file
--InsertEnter: Triggered after entering insert node
--LspAttach: Triggered afeter starting LSPs
return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- 插件加载时运行的配置
    --config = function() require("todo-comments").setup() end,
    -- 和上面的功能一样
    opts = {},
    -- 在什么条件下执行,我这是打开用户astro配置文件时打开
    event = "User AstroFile",
    -- 在不满足上面条件时，开放的命令
    cmd = { "TodoQuickFix" },
    -- 设置快捷键
    keys = {
      { "<leader>T", "<cmd>TodoTelescope<cr>", desc = "Open TODO in Telescope"}
    }
  },

  {
    "yianwillis/vimcdoc",
    event = "VeryLazy"
  }
}
