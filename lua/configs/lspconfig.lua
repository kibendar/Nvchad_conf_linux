require("nvchad.configs.lspconfig").defaults()
local servers = {
	"html",
	"cssls",
	"lua_ls",
	"pyright",
	-- "jdtls",
	"texlab",
	"clangd",
	"ts_ls",
	"remark-language-server",
	"ltex", -- This will now use ltex-ls-plus
	"ast-grep",
	"docker-compose-language-server",
	"dockerfile-language-server",
	"bash-language-server",
	"kotlin_language_server", -- Added Kotlin LSP
	-- "rust-analyzer",
}
vim.lsp.enable(servers)
vim.lsp.config("*", {
	root_markers = { ".git" },
})
vim.lsp.config("*", {
	capabilities = {
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = true,
			},
		},
	},
})
-- Java (jdtls)
-- vim.lsp.config.jdtls = {
-- 	cmd = { "jdtls" },
-- 	filetypes = { "java" },
-- 	root_markers = { ".git", "pom.xml", "build.gradle", "gradlew", ".project" },
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	single_file_support = true,
-- }
-- Kotlin (kotlin_language_server)
vim.lsp.config.kotlin_language_server = {
	cmd = { "kotlin-language-server" },
	filetypes = { "kotlin" },
	root_markers = {
		"build.gradle",
		"build.gradle.kts",
		"settings.gradle",
		"settings.gradle.kts",
		"gradlew",
		"pom.xml",
		".git",
	},
	settings = {
		kotlin = {
			-- Compiler options
			compiler = {
				jvm = {
					target = "17", -- or "11", "8" depending on your project
				},
			},
			-- Indexing settings
			indexing = {
				enabled = true,
			},
			-- Completion settings
			completion = {
				snippets = {
					enabled = true,
				},
			},
			-- Diagnostics
			diagnostics = {
				enabled = true,
			},
			-- External sources (for JAR files)
			externalSources = {
				useKlsScheme = true,
				autoConvertToKotlin = true,
			},
		},
	},
	init_options = {
		storagePath = vim.fn.stdpath("cache") .. "/kotlin-language-server",
	},
	single_file_support = true,
}
-- Python (pyright)
vim.lsp.config.pyright = {
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace",
			},
		},
	},
}
-- JS / TS (tsserver)
vim.lsp.config.tsserver = {
	cmd = { "tsserver" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
}
vim.lsp.ast_grep = {
	cmd = { "ast-grep" },
	filetypes = { "html" },
}
-- C / C++ (clangd)
vim.lsp.config.clangd = {
	cmd = {
		"clangd",
		"--clang-tidy",
		"--background-index",
		"--offset-encoding=utf-8",
	},
	filetypes = { "c", "cpp" },
	root_markers = { ".clangd", "compile_commands.json", ".git" },
}
-- Lua (lua_ls)
vim.lsp.config.lua_ls = {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},
	root_dir = function()
		return vim.fn.getcwd()
	end,
}
-- LaTeX (texlab)
vim.lsp.config.texlab = {
	settings = {
		texlab = {
			build = {
				executable = "latexmk",
				args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
				onSave = true,
			},
			forwardSearch = {
				executable = "zathura",
				args = { "--synctex-forward", "%l:1:%f", "%p" },
			},
		},
	},
}
-- LTeX-LS-Plus configuration (enhanced ltex-ls)
vim.lsp.config.ltex = {
	settings = {
		ltex = {
			language = "en-US", -- the main/default language
			enabledLanguages = { "en-US", "ru-RU", "uk-UA" },
			dictionary = {
				["en-US"] = {},
				["ru-RU"] = {},
				["uk-UA"] = {},
			},
			-- disabledRules = {
			--   ["en-US"] = {},
			--   ["ru-RU"] = {},
			--   ["uk-UA"] = {},
			-- },
			hiddenFalsePositives = {
				["en-US"] = {},
				["ru-RU"] = {},
				["uk-UA"] = {},
			},
			-- Enhanced ltex-ls-plus specific settings
			additionalRules = {
				enablePickyRules = true,
				motherTongue = "en-US",
			},
			-- Performance improvements
			sentenceCacheSize = 2000,
			completionEnabled = true,
			-- External dictionary support (ltex-ls-plus feature)
			externalDictionary = {
				enabled = false,
				-- path = "/path/to/your/dictionary.txt", -- uncomment and set path if needed
			},
			-- Better multilingual support
			languageToolHttpServerUri = "", -- leave empty for local processing
			languageToolOrgUsername = "",
			languageToolOrgApiKey = "",
		},
	},
	cmd = { "ltex-ls-plus" }, -- Changed from "ltex-ls" to "ltex-ls-plus"
	filetypes = {
		"bib",
		"gitcommit",
		"markdown",
		"org",
		"plaintex",
		"rst",
		"rnoweb",
		"tex",
		"pandoc",
		"quarto",
		"rmd",
		"context",
		"html",
		"xhtml",
		"mail",
		"text",
	},
	root_markers = { ".git" },
	single_file_support = true,
	-- Additional capabilities specific to ltex-ls-plus
	init_options = {
		customCapabilities = {
			workspaceSpecificConfiguration = true,
		},
	},
}
-- Remark LSP (remark-language-server)
vim.lsp.config["remark-language-server"] = {
	cmd = { "remark-language-server", "--stdio" },
	filetypes = { "markdown" },
	root_dir = function(fname)
		return vim.fs.dirname(vim.fs.find({ ".git", ".remarkrc" }, { upward = true })[1])
	end,
}
-- Docker Compose LSP
vim.lsp.config["docker-compose-language-server"] = {
	cmd = { "docker-compose-langserver", "--stdio" },
	filetypes = { "yaml.docker-compose", "yaml" },
	root_markers = { "docker-compose.yml", "docker-compose.yaml", "compose.yml", "compose.yaml", ".git" },
	settings = {
		dockerCompose = {
			enable = true,
		},
	},
}
-- Dockerfile LSP
vim.lsp.config["dockerfile-language-server"] = {
	cmd = { "docker-langserver", "--stdio" },
	filetypes = { "dockerfile" },
	root_markers = { "Dockerfile", "dockerfile", ".dockerignore", ".git" },
	settings = {
		docker = {
			languageserver = {
				diagnostics = {
					-- Enable all diagnostics
					deprecatedMaintainer = true,
					directiveCasing = true,
					emptyContinuationLine = true,
					instructionCasing = true,
					instructionCmdMultiple = true,
					instructionEntrypointMultiple = true,
					instructionHealthcheckMultiple = true,
					instructionJSONInSingleQuotes = true,
				},
				formatter = {
					ignoreMultilineInstructions = true,
				},
			},
		},
	},
}
-- Bash LSP (bash-language-server)
vim.lsp.config["bash-language-server"] = {
	cmd = { "bash-language-server", "start" },
	filetypes = { "sh", "bash" },
	root_markers = { ".git", ".bashrc", ".bash_profile" },
	settings = {
		bashIde = {
			-- Enable/disable background analysis
			backgroundAnalysisMaxFiles = 500,
			-- Enable/disable shellcheck integration
			enableSourceErrorDiagnostics = false,
			-- Glob pattern for files to include in workspace symbol search
			includeAllWorkspaceSymbols = true,
			-- Path to shellcheck executable (optional)
			shellcheckPath = "shellcheck",
			-- ShellCheck arguments (optional)
			shellcheckArguments = "--external-sources",
		},
	},
	single_file_support = true,
}
