require("diffview").setup({
  -- Use git's own diff to colour hunks, closer to the delta output in the pager
  enhanced_diff_hl = true,
  view = {
    merge_tool = {
      -- BASE | OURS | THEIRS on the top row, working copy below. BASE is the ply `:diffget //1`
      -- would have given us, which Gvdiffsplit! never exposed
      layout = "diff4_mixed",
      disable_diagnostics = true,
      winbar_info = true,
    },
    file_history = {
      winbar_info = true,
    },
  },
})
