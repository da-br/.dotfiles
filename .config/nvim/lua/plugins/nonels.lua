return {
	"nvimtools/none-ls.nvim",
	optional = true,
	dependencies = {
		{
			"williamboman/mason.nvim",
			opts = { ensure_installed = { "gomodifytags", "impl" } },
		},
	},
	opts = function(_, opts)
		local nls = require("null-ls")
		opts.sources = vim.list_extend(opts.sources or {}, {
			nls.builtins.code_actions.refactoring,
			nls.builtins.code_actions.gomodifytags,
			nls.builtins.code_actions.impl,
			nls.builtins.formatting.goimports,
			nls.builtins.formatting.gofumpt,
			nls.builtins.formatting.golines,
			nls.builtins.diagnostics.golangci_lint,
			nls.builtins.diagnostics.staticcheck,
		})
	end,
}
