return {
  "jiriks74/presence.nvim",
  event = "UIEnter",
  config = function()
    -- The setup config table shows all available config options with their default values:
    require("presence").setup({
      -- General options
      auto_update       = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
      neovim_image_text = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
      main_image        = "neovim",                   -- Main image display (either "neovim" or "file")
      log_level         = "debug",                    -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
    })
  end,
  enabled = false
}
