return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
    init = function()
      -- 可选：设置为关闭时自动关闭浏览器窗口
      vim.g.mkdp_auto_close = 1
      -- 可选：默认使用的浏览器
      vim.g.mkdp_browser = "google-chrome" -- 或 "firefox"、"edge" 等
    end
  }
}
