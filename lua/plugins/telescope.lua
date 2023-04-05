local actions = require("telescope.actions")

return {
  "nvim-telescope/telescope.nvim",
  -- change some options
  opts = {
    defaults = {
      layout_strategy = "horizontal",
      sorting_strategy = "ascending",
      layout_config = {
        width = function(_, max_columns, _)
          return max_columns
        end,
        height = function(_, _, max_lines)
          return max_lines
        end,
        prompt_position = "top",
        preview_width = 0.7,
      },
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
        },
        -- for normal mode
        n = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
      },
    },
  },
}
