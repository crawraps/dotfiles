local function mappings(buf)
  local map = vim.keymap.set
  local opts = { buffer = buf }

  map('n', 'gl', '<cmd>Navbuddy<CR>', opts)
  map('n', ',f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
  map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  map('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  map('i', '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- map('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  map('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  map('n', '<leader>c', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- map('v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  map('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  map('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  map('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  -- map('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  -- map('n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
end

local function snippetsConfig()
  local types = require('luasnip.util.types')

  require('luasnip').setup({
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { '●', 'DiffAdd' } },
        },
      },
      [types.insertNode] = {
        active = {
          virt_text = { { '●', 'DiffDelete' } },
        },
      },
    },
  })

  -- Loading any vscode snippets from plugins
  require('luasnip.loaders.from_vscode').lazy_load()

  -- Allow jsx and tsx to use js snippets
  require('luasnip').filetype_extend('javascript', { 'javascriptreact', 'typescriptreact' })

  -- Mappins to move around inside snippets
  vim.keymap.set({ 'i', 's' }, '<C-j>', '<CMD>lua require("luasnip").jump(1)<CR>')
  vim.keymap.set({ 'i', 's' }, '<C-k>', '<CMD>lua require("luasnip").jump(-1)<CR>')
end

local function cmpOpts()
  local cmp = require('cmp')

  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local next_comp = function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
      -- elseif luasnip.expand_or_jumpable() then
      --   luasnip.expand_or_jump()
    elseif has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end

  local prev_comp = function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
      -- elseif luasnip.jumpable(-1) then
      --   luasnip.jump(-1)
    else
      fallback()
    end
  end

  return {
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-e>'] = cmp.config.disable,
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<C-Space>'] = cmp.mapping.complete(),
      --['<Tab>'] = cmp.mapping(next_comp, { "i", "s" }),
      --['<S-Tab>'] = cmp.mapping(prev_comp, { "i", "s" }),
      ['<M-j>'] = cmp.mapping(next_comp, { "i", "s" }),
      ['<M-k>'] = cmp.mapping(prev_comp, { "i", "s" }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp', max_item_count = 20 },
      { name = 'luasnip',  max_item_count = 20 },
      { name = 'path',     max_item_count = 10 },
      { name = 'buffer',   max_item_count = 10 },
    })
  }
end

local function on_attach(client, buf)
  mappings(buf)

  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, buf)
    require("nvim-navbuddy").attach(client, buf)
  end
end

local function lspConfig()
  local lsp = require('lspconfig')
  local lspconfig = require('lspconfig')
  local util = require('lspconfig.util')
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  ---Common perf related flags for all the LSP servers
  local flags = {
    allow_incremental_sync = true,
    debounce_text_changes = 200,
  }

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
    on_new_config = function(new_config, new_root_dir)
      new_config.init_options.typescript.tsdk = util.path.join(new_root_dir, 'node_modules', 'typescript', 'lib')
    end,
  })

  -- typescript
  lspconfig.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
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
    }
  }
end

local function lspInit()
  -- Disable LSP logging
  vim.lsp.set_log_level(vim.lsp.log_levels.OFF)

  -- Configuring native diagnostics
  vim.diagnostic.config({
    virtual_text = {
      prefix = "·",
      spacing = 2,
      virt_text_pos = "eol",
    },
    float = true,
  })

  for _, diag in ipairs({ "Error", "Warn", "Info", "Hint" }) do
    vim.fn.sign_define("DiagnosticSign" .. diag, {
      text = "",
      texthl = "DiagnosticSign" .. diag,
      linehl = "",
      numhl = "DiagnosticSign" .. diag,
    })
  end
end

return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    config = snippetsConfig,
    lazy = true,
  },
  {
    "saadparwaiz1/cmp_luasnip",
    lazy = true,
  },
  {
    'hrsh7th/cmp-path',
    lazy = true,
  },
  {
    'hrsh7th/cmp-buffer',
    lazy = true,
  },
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    dependencies = { "LuaSnip", "cmp_luasnip", "cmp-path", "cmp-buffer" },
    event = "InsertEnter",
    opts = cmpOpts,
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = true,
  },
  {
    "williamboman/mason.nvim",
    lazy = true,
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    opts = {
      ensure_installed = {
        "lua_ls",
        "tsserver"
      },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({
            on_attach = on_attach,
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
            flags = {
              allow_incremental_sync = true,
              debounce_text_changes = 200,
            }
          })
        end,
      }
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    dependencies = { "cmp-nvim-lsp", "mason-lspconfig.nvim", "nvim-navic", "nvim-navbuddy" },
    config = lspConfig,
    init = lspInit,
  },
  {
    "zbirenbaum/copilot.lua",
    lazy = true,
    event = "InsertEnter",
    opts = {
      panel = {
        auto_refresh = true,
        layout = {
          position = "right",
          ratio = 0.3,
        },
      },
      suggestion = {
        auto_trigger = true,
        accept = false,
      },
    },
    init = function()
      vim.keymap.set("i", '<Tab>', function()
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
        end
      end, {
        silent = true,
      })
    end
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    event = "VeryLazy",
    dependencies = { "copilot.lua", "plenary.nvim" },
    config = true,
  },
}
