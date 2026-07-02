require("nvim-treesitter").setup({
    ensure_installed = {
        "bash", "c", "css", "cpp", "go", "html",
        "java", "javascript", "json", "lua",
        "markdown", "markdown_inline",
        "python", "rust", "tsx", "typescript"
    },
})
