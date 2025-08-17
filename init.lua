-- Load core configs
require 'core.keymaps'
require 'core.options'
require 'core.autocommands'

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require('lazy').setup({
  {
    'webhooked/kanso.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'kanso'
    end,
  },
  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = true } },
  require 'plugins.lualine',
  require 'plugins.debug',
  require 'plugins.indent_line',
  require 'plugins.lint',
  require 'plugins.mason',
  require 'plugins.autopairs',
  require 'plugins.neo-tree',
  require 'plugins.gitsigns',
  require 'plugins.oil',
  require 'plugins.whichkey',
  require 'plugins.telescope',
  require 'plugins.treesitter',
  require 'plugins.mini',
  require 'plugins.lazydev',
  require 'plugins.lsp',
  require 'plugins.conform',
  require 'plugins.blink',
  require 'plugins.render-markdown',
  -- require 'plugins.roslyn',
  require 'plugins.snipe',
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
