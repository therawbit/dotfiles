return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "mason.nvim",
        {
            "williamboman/mason-lspconfig.nvim",
            opts = { automatic_installation = true }
        }, 'cmp-nvim-lsp'
    },
    config = function()
        local lsp_config = require("lspconfig")
        require("lspconfig.ui.windows").default_options.border = "rounded"


        local servers = require("mason-lspconfig").get_installed_servers()


        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities =
            require('cmp_nvim_lsp').default_capabilities(capabilities)
        local handlers = {
            ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
            ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" }),
        }

        for _, server in ipairs(servers) do
            local opts = { on_attach = on_attach, capabilities = capabilities, handlers = handlers }

            -- Load additional settings if its available
            local available, options = pcall(require,
                "immo.lsp.options." .. server)
            if available then
                opts = vim.tbl_deep_extend("force", opts, options)
            end

            lsp_config[server].setup(opts)
        end
    end
}
