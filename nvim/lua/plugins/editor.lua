return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = { style = "night" },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = { options = { theme = "auto", globalstatus = true } },
  },
  { "lewis6991/gitsigns.nvim", event = { "BufReadPre", "BufNewFile" }, opts = {} },
  { "echasnovski/mini.surround", version = "*", event = "VeryLazy", opts = {} },
  { "echasnovski/mini.comment", version = "*", event = "VeryLazy", opts = {} },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local languages = {
        "bash", "css", "diff", "git_config", "git_rebase", "go", "html",
        "javascript", "json", "lua", "markdown", "markdown_inline", "php",
        "ruby", "tsx", "typescript", "vim", "vimdoc", "yaml",
      }
      require("nvim-treesitter").install(languages)
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },
}
