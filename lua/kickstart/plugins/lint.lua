return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' }, -- Markdown linter
        dockerfile = { 'hadolint' }, -- Dockerfile linter
        json = { 'jsonlint' }, -- JSON linter
        javascript = { 'eslint' }, -- JavaScript linter
        typescript = { 'eslint' }, -- TypeScript linter
        python = { 'flake8' }, -- Python linter
        rust = { 'cargo' }, -- Rust linter (via cargo check)
        cpp = { 'clangtidy' }, -- C++ linter
        c = { 'clangtidy' }, -- C linter
        yaml = { 'yamllint' }, -- YAML linter
        terraform = { 'tflint' }, -- Terraform linter
        text = { 'vale' }, -- Text linter
        sql = { 'sqlfluff' }, -- SQL linter
      }

      -- Autocommand for linting on specific events
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
