return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>t", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>f", "<cmd>Telescope live_grep<cr>", desc = "Find text" },
      { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
      { "<leader>h", "<cmd>Telescope help_tags<cr>", desc = "Find help" },
    },
    opts = {
      defaults = {
        file_ignore_patterns = { "%.git/", "node_modules/", "vendor/", "tmp/" },
      },
    },
  },
}
