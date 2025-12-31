return {
  {
    "pocco81/auto-save.nvim",
    enable = true,
    trigger_events = { "InsertLeave" }, -- vim events that trigger auto-save. See :h events
    -- function that determines whether to save the current buffer or not
    -- return true: if buffer is ok to be saved
    -- return false: if it's not ok to be saved
  },
}
