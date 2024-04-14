vim.filetype.add({
  pattern = {
    ["%.env%.[%w_.-]+"] = "sh",
  },
})

return {}
