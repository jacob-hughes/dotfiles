require("mason-lspconfig").setup({
    ensure_installed = {
        "bashls",
        "clangd",
        "dockerls",
        "docker_compose_language_service",
        "neocmake",
        "pyright",
    },
    automatic_installation = true,
})
