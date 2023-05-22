local on_attach = require('plugins.configs.lspconfig').on_attach
local capabilities = require('plugins.configs.lspconfig').capabilities

local lspconfig = require('lspconfig')

-- if you just want default config for the servers then put them in a table
local servers = { 'html', 'cssls' }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

-- set up tsserver
local function organize_imports()
  local params = {
    command = '_typescript.organizeImports',
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = '',
  }
  vim.lsp.buf.execute_command(params)
end

local function rename_file()
  local source_file = vim.api.nvim_buf_get_name(0)
  local target_file = ''

  vim.ui.input({
    prompt = 'Target : ',
    completion = 'file',
    default = source_file,
  }, function(input)
    if input ~= nil then
      target_file = input
    end
  end)

  -- return if input is canceled
  if target_file == '' then
    return
  end

  local params = {
    command = '_typescript.applyRenameFile',
    arguments = {
      {
        sourceUri = source_file,
        targetUri = target_file,
      },
    },
  }

  vim.lsp.util.rename(source_file, target_file)
  vim.cmd('e')
  vim.lsp.buf.execute_command(params)
end

lspconfig.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  commands = {
    OrganizeImports = {
      organize_imports,
      description = 'Organize Imports',
    },
    RenameFile = {
      rename_file,
      description = 'Rename File',
    },
  },
})
-- end set up tsserver
