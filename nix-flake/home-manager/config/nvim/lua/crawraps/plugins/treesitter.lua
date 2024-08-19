return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
  },
  {
    "nvim-treesitter/nvim-treesitter-refactor",
    lazy = true,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter-textobjects", "nvim-treesitter-refactor" },
    opts = {
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      refactor = {
        highlight_definitions = { enable = true },
        highlight_current_scope = { enable = false },
      },
    }
  },
}
