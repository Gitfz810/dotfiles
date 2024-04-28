-- formatting & linting
return {
  "nvimtools/none-ls.nvim",
  config = function()
    -- import null-ls plugin safely
    local setup, null_ls = pcall(require, "null-ls")
    if not setup then
      vim.notify("null-ls not found")
      return
    end

    -- for conciseness
    local formatting = null_ls.builtins.formatting -- to setup formatters
    -- local code_actions = null_ls.builtins.code_actions -- to setup code actions
    -- local completion = null_ls.builtins.completion -- to setup completion
    local diagnostics = null_ls.builtins.diagnostics -- to setup linters

    -- to setup format on save
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    -- configure null_ls
    null_ls.setup({
      -- debug = true, -- enable debug mode and get debug output
      -- setup builtins sources for null-ls
      sources = {
        -- to disable file types use
        -- "formatting.prettier.with({disabled_filetypes = {}})" (see null-ls docs)
        formatting.stylua, -- lua formatter
        formatting.buf, -- protocol buffer formatter
        -- formatting.yamlfmt, -- yaml formatter
        formatting.sql_formatter, -- sql formatter
        -- formatting.jq, -- json formatter
        -- formatting.beautysh, -- shell formatter
        formatting.erlfmt, -- erlang formatter
        -- formatting.black, -- more popular python formatter
        -- formatting.autopep8, -- python formatter
        -- formatting.rustfmt, -- rust formatter
        -- code_actions.cspell, -- spell checker
        -- diagnostics.cspell, -- spell checker
        -- diagnostics.shellcheck, -- shell script static analysis tool
        diagnostics.editorconfig_checker.with({ -- a tool to verify with .editorconfig
          disabled_filetypes = { "erlang", "markdown", "python" }, -- disable editorconfig checker
        }),
        -- configuration of yamllint: https://yamllint.readthedocs.io/en/stable/configuration.html
        diagnostics.yamllint, -- yaml linter
        diagnostics.buf, -- working with Protocol Buffers
        diagnostics.fish, -- basic linting is available for fish scripts
        -- diagnostics.ruff, -- python linter written by rust
      },
      -- configure format on save
      on_attach = function(current_client, bufnr)
        if current_client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                filter = function(client)
                  --  only use null-ls for formatting instead of lsp server
                  return client.name == "null-ls"
                end,
                bufnr = bufnr,
              })
            end,
          })
        end
      end,
    })
  end,
}