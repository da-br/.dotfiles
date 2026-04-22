return {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            "williamboman/mason.nvim",
            opts = {
                ensure_installed = {
                    "typescript-language-server",
                    "svelte-language-server",
                    "prettier",
                    "eslint-lsp",
                },
            },
        },
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "stevearc/conform.nvim",
    },

    config = function()
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "ts_ls",
                "zls",
                -- "svelte"
            },

            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                    })
                end,

                zls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.zls.setup({
                        root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
                        settings = {
                            zls = {
                                enable_inlay_hints = true,
                                enable_snippets = true,
                                warn_style = true,
                            },
                        },
                    })
                    vim.g.zig_fmt_parse_errors = 0
                    vim.g.zig_fmt_autosave = 0
                end,

                lua_ls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                    })
                end,

                -- Enhanced Svelte configuration for SvelteKit
                svelte = function()
                    require("lspconfig").svelte.setup({
                        capabilities = capabilities,
                        root_dir = require("lspconfig").util.root_pattern("svelte.config.js", "svelte.config.mjs",
                            "svelte.config.cjs", "package.json"),
                        settings = {
                            svelte = {
                                plugin = {
                                    svelte = {
                                        enable = true,
                                        compilerWarnings = {
                                            ["a11y-accesskey"] = "ignore",
                                            ["a11y-incorrect-aria-attribute-type"] = "ignore",
                                            ["a11y-unknown-aria-attribute"] = "ignore",
                                            ["a11y-hidden"] = "ignore",
                                            ["a11y-misplaced-role"] = "ignore",
                                            ["a11y-unknown-role"] = "ignore",
                                            ["a11y-no-abstract-role"] = "ignore",
                                            ["a11y-no-redundant-roles"] = "ignore",
                                            ["a11y-role-has-required-aria-props"] = "ignore",
                                            ["a11y-aria-props"] = "ignore",
                                            ["a11y-no-interactive-element-to-noninteractive-role"] = "ignore",
                                            ["a11y-positive-tabindex"] = "ignore",
                                            ["a11y-invalid-attribute"] = "ignore",
                                            ["a11y-missing-attribute"] = "ignore",
                                            ["a11y-img-redundant-alt"] = "ignore",
                                            ["a11y-label-has-associated-control"] = "ignore",
                                            ["a11y-media-has-caption"] = "ignore",
                                            ["a11y-distracting-elements"] = "ignore",
                                            ["a11y-structure"] = "ignore",
                                            ["a11y-mouse-events-have-key-events"] = "ignore",
                                            ["a11y-missing-content"] = "ignore",
                                        },
                                    },
                                    html = {
                                        enable = true,
                                        completions = {
                                            emmet = true,
                                        },
                                    },
                                    css = {
                                        enable = true,
                                        globals = true,
                                        completions = {
                                            emmet = true,
                                        },
                                    },
                                    typescript = {
                                        enable = true,
                                        diagnostics = { enable = true },
                                        hover = { enable = true },
                                        completions = { enable = true },
                                        codeActions = { enable = true },
                                        selectionRange = { enable = true },
                                        signatureHelp = { enable = true },
                                        semanticTokens = { enable = true },
                                    },
                                },
                            },
                        },
                        on_attach = function(client, bufnr)
                            -- Disable formatting for Svelte files, let Prettier handle it
                            client.server_capabilities.documentFormattingProvider = false
                            client.server_capabilities.documentRangeFormattingProvider = false
                        end,
                    })
                end,

                -- TypeScript configuration optimized for SvelteKit
                ts_ls = function()
                    require("lspconfig").ts_ls.setup({
                        capabilities = capabilities,
                        root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json",
                            "jsconfig.json"),
                        init_options = {
                            plugins = {
                                {
                                    name = "@vue/typescript-plugin",
                                    location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
                                    languages = { "javascript", "typescript", "vue" },
                                },
                            },
                        },
                        filetypes = {
                            "javascript",
                            "javascriptreact",
                            "javascript.jsx",
                            "typescript",
                            "typescriptreact",
                            "typescript.tsx",
                        },
                        settings = {
                            typescript = {
                                inlayHints = {
                                    includeInlayParameterNameHints = "all",
                                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                    includeInlayFunctionParameterTypeHints = true,
                                    includeInlayVariableTypeHints = true,
                                    includeInlayPropertyDeclarationTypeHints = true,
                                    includeInlayFunctionLikeReturnTypeHints = true,
                                    includeInlayEnumMemberValueHints = true,
                                },
                            },
                            javascript = {
                                inlayHints = {
                                    includeInlayParameterNameHints = "all",
                                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                    includeInlayFunctionParameterTypeHints = true,
                                    includeInlayVariableTypeHints = true,
                                    includeInlayPropertyDeclarationTypeHints = true,
                                    includeInlayFunctionLikeReturnTypeHints = true,
                                    includeInlayEnumMemberValueHints = true,
                                },
                            },
                        },
                        on_attach = function(client, bufnr)
                            -- Disable formatting for TS files, let Prettier handle it
                            client.server_capabilities.documentFormattingProvider = false
                            client.server_capabilities.documentRangeFormattingProvider = false
                        end,
                    })
                end,

                eslint = function()
                    require("lspconfig").eslint.setup({
                        capabilities = capabilities,
                        root_dir = require("lspconfig").util.root_pattern(
                            ".eslintrc",
                            ".eslintrc.js",
                            ".eslintrc.cjs",
                            ".eslintrc.yaml",
                            ".eslintrc.yml",
                            ".eslintrc.json",
                            "eslint.config.js",
                            "package.json"
                        ),
                        settings = {
                            codeAction = {
                                disableRuleComment = {
                                    enable = true,
                                    location = "separateLine"
                                },
                                showDocumentation = {
                                    enable = true
                                }
                            },
                            codeActionOnSave = {
                                enable = false,
                                mode = "all"
                            },
                            experimental = {
                                useFlatConfig = false
                            },
                            format = true,
                            nodePath = "",
                            onIgnoredFiles = "off",
                            packageManager = "npm",
                            problems = {
                                shortenToSingleLine = false
                            },
                            quiet = false,
                            rulesCustomizations = {},
                            run = "onType",
                            useESLintClass = false,
                            validate = "on",
                            workingDirectory = {
                                mode = "location"
                            }
                        },
                        filetypes = {
                            "javascript",
                            "javascriptreact",
                            "typescript",
                            "typescriptreact",
                            "svelte"
                        },
                    })
                end,
            },
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })

        local servers = {
            bashls = true,
        }

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local bufnr = args.buf
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

                local settings = servers[client.name]
                if type(settings) ~= "table" then
                    settings = {}
                end

                local builtin = require("telescope.builtin")

                vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
                vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
                vim.keymap.set("n", "gi", builtin.lsp_implementations, { buffer = 0 })
                vim.keymap.set("n", "gs", builtin.lsp_document_symbols, { buffer = 0 })
                vim.keymap.set("n", "gS", builtin.lsp_workspace_symbols, { buffer = 0 })
                vim.keymap.set("n", "gu", builtin.lsp_references, { buffer = 0 })
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
                vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { buffer = 0 })
                vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

                vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
                vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })
                vim.keymap.set("x", "<space>ca", vim.lsp.buf.range_code_action, { buffer = 0 })

                -- Override server capabilities
                if settings.server_capabilities then
                    for k, v in pairs(settings.server_capabilities) do
                        if v == vim.NIL then
                            ---@diagnostic disable-next-line: cast-local-type
                            v = nil
                        end

                        client.server_capabilities[k] = v
                    end
                end
            end,
        })
    end,
}
