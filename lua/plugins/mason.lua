return {
  'mason-org/mason.nvim',
  opts = {
    registries = {
      'github:mason-org/mason-registry',
      'github:crashdummyy/mason-registry',
    },
    ensure_installed = {
      'stylua',
      'csharpier',
      'netcoredbg',
      'roslyn',
      'rzls',
      'lua-language-server',
      'html-lsp',
    },
  },
}
