local present, wilder = pcall(require, "wilder")

if not present then
  return
end

wilder.setup {
  modes = { ":", "/", "?" },
  next_key = "<C-n>",
  previous_key = "<C-p>",
}

wilder.set_option(
  "renderer",
  wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
    highlights = {
      border = "Normal", -- highlight to use for the border
    },
    -- 'single', 'double', 'rounded' or 'solid'
    -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
    border = "rounded",
    max_height = "50%", -- max height of the palette
    min_height = 0, -- set to the same as 'max_height' for a fixed height
    prompt_position = "top", -- 'top' or 'bottom' to set the location of the prompt
    reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
  })
)
