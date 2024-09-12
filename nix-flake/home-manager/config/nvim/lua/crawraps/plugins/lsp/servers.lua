local mappings = require('crawraps.plugins.lsp.mappings')

---Common perf related flags for all the LSP servers
local flags = {
  allow_incremental_sync = true,
  debounce_text_changes = 200,
}

local function on_attach(client, buf)
  mappings(buf)

  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, buf)
    require("nvim-navbuddy").attach(client, buf)
  end
end

local function configure_common_server(server_name)
  local lsp = require('lspconfig')
  local lspconfig = require('lspconfig')
  local util = require('lspconfig.util')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  require("lspconfig")[server_name].setup({
    on_attach = require('crawraps.plugins.lsp.servers').on_attach,
    capabilities = capabilities,
    flags = flags,
  })
end

local function configure_servers()
  local lsp = require('lspconfig')
  local lspconfig = require('lspconfig')
  local util = require('lspconfig.util')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  -- Lua
  lsp.lua_ls.setup({
    flags = flags,
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        completion = {
          enable = true,
          showWord = 'Disable',
          -- keywordSnippet = 'Disable',
        },
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = { os.getenv('VIMRUNTIME') },
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  })

  -- Rust
  lsp.rust_analyzer.setup({
    flags = flags,
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      ['rust-analyzer'] = {
        cargo = {
          allFeatures = true,
        },
        checkOnSave = {
          allFeatures = true,
          command = 'clippy',
        },
        procMacro = {
          ignored = {
            ['async-trait'] = { 'async_trait' },
            ['napi-derive'] = { 'napi' },
            ['async-recursion'] = { 'async_recursion' },
          },
        },
      },
    },
  })

  -- Vue
  lsp.volar.setup({
    flags = flags,
    capabilities = capabilities,
    on_attach = on_attach,
    init_options = {
      vue = {
        hybridMode = false,
      },
    },
    on_new_config = function(new_config, new_root_dir)
      new_config.init_options.typescript.tsdk = util.path.join(new_root_dir, 'node_modules', 'typescript', 'lib')
    end,
  })

  local mason_registry = require('mason-registry')
  local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() ..
      '/node_modules/@vue/language-server'

  -- typescript
  lspconfig.ts_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
      plugins = {
        {
          name = '@vue/typescript-plugin',
          location = vue_language_server_path,
          languages = { 'vue' },
        },
      },
    },
    commands = {
      OrganizeImports = {
        function()
          local params = {
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(0) },
            title = "Organize imports"
          }
          vim.lsp.buf.execute_command(params)
        end,
        description = "Organize Imports"
      }
    },
  }
end

return {
  on_attach = on_attach,
  configure_servers = configure_servers,
  configure_common_server = configure_common_server,
  capabilities = capabilities,
  flags = flags,
}
