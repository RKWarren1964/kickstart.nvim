-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true

vim.o.undofile = true
vim.o.tabstop = 2
--
-- Set folding options
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.g.netrw_browsex_viewer = 'xdg-open'

vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- Build the winbar text string
-- RKW 2025.02.08
function _G.get_winbar()
  -- Create our own highlight group for the file modified state
  vim.api.nvim_set_hl(0, 'FileModified', { fg = '#ff0000', bold = false, italic = true })

  -- Create our own highlight group for the buffer count
  vim.api.nvim_set_hl(0, 'BufferCount', { fg = 'orange', bold = false, italic = false })

  -- Create our own highlight group for the any file modified state
  vim.api.nvim_set_hl(0, 'AnyFileModified', { fg = 'yellow', bold = false, italic = false })

  local filepath = vim.fn.expand '%:p:~:.' -- Get the file path (shortened)

  -- Check if ANY buffer is modified
  local modified_buffers = false -- Flag to track if ANY buffer is modified
  for _, buf in ipairs(vim.fn.getbufinfo { buflisted = 1 }) do
    if vim.bo[buf.bufnr].modified then
      modified_buffers = true
      break -- Exit loop early once a modified buffer is found
    end
  end
  local modified_indicator = modified_buffers and '%#AnyFileModified#[*]%*' or '' -- * if any buffer is modified
  local modified = vim.bo.modified and '%#FileModified#[+]%*' or '' -- Red color for modified state
  local buffer_count = #vim.fn.getbufinfo { buflisted = 1 } -- Count of open buffers
  local buffer_count_text = '%#BufferCount#(' .. buffer_count .. ')%*'
  return string.format('%s %s %s %%#Title#%s%%*', buffer_count_text, modified, modified_indicator, filepath)
end

-- Displays the winbar text in the header line
-- RKW 2025.02.08
vim.opt.winbar = '%{%v:lua.get_winbar()%}'

-- Set textwidth based on filetype, create an autocommand group to avoid duplicates
local markdown_group = vim.api.nvim_create_augroup('MarkdownSettings', { clear = true })

-- Set textwidth=80 for selected files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  group = markdown_group,
  callback = function()
    vim.bo.textwidth = 80 -- buffer-local option
    -- Optional: Add other Markdown-specific settings here
    -- vim.bo.wrap = true   -- enable line wrapping
  end,
})

-- Diagnostic configuration settings
vim.diagnostic.config {
  virtual_lines = { current_line = false },
  float = {
    focusable = true,
    style = 'default',
    border = 'double',
    source = true,
    header = '',
    prefix = '',
  },
}
