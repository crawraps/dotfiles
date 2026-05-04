local lsp = require('lspconfig')
local U = require('crawraps.plugins.lsp.utils')
local navic = require('nvim-navic')
local navbuddy = require("nvim-navbuddy")

---Common perf related flags for all the LSP servers
local flags = {
    allow_incremental_sync = true,
    debounce_text_changes = 200,
}

---Common capabilities including lsp snippets and autocompletion
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()

---Common `on_attach` function for LSP servers
---@param client table
---@param buf integer
local function on_attach(client, buf)
    ---Disable formatting for servers (Handled by null-ls)
    ---@see https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    ---Disable |lsp-semantic_tokens| (conflicting with TS highlights)
    client.server_capabilities.semanticTokensProvider = nil

    ---LSP Mappings
    U.mappings(buf)

    --- Breadcrumbs
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, buf)
        navbuddy.attach(client, buf)
    end
end

-- Disable LSP logging
vim.lsp.set_log_level(vim.lsp.log_levels.OFF)

-- Configuring native diagnostics
vim.diagnostic.config({
    virtual_text = true,
    float = true,
})

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

-- Angular
-- 1. install @angular/language-server globally
-- 2. install @angular/language-service inside project as dev dep
-- lsp.angularls.setup({
--     flags = flags,
--     capabilities = capabilities,
--     on_attach = function(client, buf)
--         client.server_capabilities.renameProvider = false
--         on_attach(client, buf)
--     end,
-- })

-- Vue
local util = require 'lspconfig.util'
local function get_typescript_server_path(root_dir)

  local global_ts = '/home/careem/.local/nvm/versions/node/v18.17.1/lib/node_modules/typescript/lib'
  -- Alternative location if installed as root:
  -- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
  local found_ts = ''
  local function check_dir(path)
    found_ts =  util.path.join(path, 'node_modules', 'typescript', 'lib')
    if util.path.exists(found_ts) then
      return path
    end
  end
  if util.search_ancestors(root_dir, check_dir) then
    return found_ts
  else
    return global_ts
  end
end

lsp.volar.setup({
  flags = flags,
  capabilities = capabilities,
  on_attach = on_attach,
  on_new_config = function(new_config, new_root_dir)
    new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
  end,
})

local lspconfig = require('lspconfig')

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports"
    }
  }
}

---List of the LSP server that don't need special configuration
local servers = {
    'zls', -- Zig
    'gopls', -- Golang
    'html', -- HTML
    'cssls', -- CSS
    'jsonls', -- Json
    'yamlls', -- YAML
    'emmet_ls', -- emmet-ls
    -- 'tailwindcss',
    'csharp_ls',
    -- 'terraformls', -- Terraform
}

local conf = {
    flags = flags,
    capabilities = capabilities,
    on_attach = on_attach,
}

for _, server in ipairs(servers) do
    lsp[server].setup(conf)
end

-- NOTE: Using `eslint_d` via `null-ls` bcz it is way fasterrrrrrr.
-- Eslint
--[[ lsp.eslint.setup({
    flags = flags,
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        useESLintClass = true, -- Recommended for eslint >= 7
        run = 'onSave', -- Run `eslint` after save
    },
    -- NOTE: `root_dir` is required to fix the monorepo issue
    root_dir = require('lspconfig.util').find_git_ancestor,
}) ]]
