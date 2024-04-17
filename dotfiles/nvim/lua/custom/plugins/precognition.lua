return {
  'tris203/precognition.nvim',
  enabled = false,
  event = 'VeryLazy',
  dev = true,
  --  enabled = false,
  opts = {
    startVisible = false,
  },
  keys = {
    {
      '<leader>pr',
      function()
        require('precognition').toggle()
      end,
    },
  },
}
