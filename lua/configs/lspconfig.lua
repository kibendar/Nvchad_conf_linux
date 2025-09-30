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
	"ast-grep",
	"docker-compose-language-server",
	"dockerfile-language-server",
	"bash-language-server",
	"kotlin_language_server", -- Added Kotlin LSP
	"rust-analyzer",
	"lemminx",
	"marksman",
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

-- Markdown (marksman)
vim.lsp.config.marksman = {
	cmd = { "marksman", "server" },
	filetypes = { "markdown", "markdown.mdx" },
	root_markers = {
		".marksman.toml",
		".git",
		".obsidian",
		"README.md",
	},
	settings = {
		marksman = {
			-- Completion settings
			completion = {
				wiki = {
					enabled = true,
				},
			},
			-- Cross-references and linking
			references = {
				enabled = true,
			},
			-- Document symbols
			outline = {
				enabled = true,
			},
			-- Hover information
			hover = {
				enabled = true,
			},
			-- Diagnostics
			diagnostics = {
				enabled = true,
			},
			-- Wiki-style linking (useful for note-taking)
			wiki = {
				enabled = true,
			},
		},
	},
	single_file_support = true,
}
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
	cmd_env = {
		JAVA_HOME = "/usr/lib/jvm/java-21-openjdk",
		PATH = "/usr/lib/jvm/java-21-openjdk/bin:" .. vim.env.PATH,
	},
	settings = {
		kotlin = {
			-- Compiler options
			compiler = {
				jvm = {
					target = "21", -- or "11", "8" depending on your project
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
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json",
		".git",
	},
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace", -- or "openFilesOnly" for better performance
				typeCheckingMode = "basic", -- "off", "basic", or "strict"
			},
		},
	},
	single_file_support = true,
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
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},
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

-- XML (lemminx)
vim.lsp.config.lemminx = {
	cmd = { "lemminx" },
	filetypes = { "xml", "xsd", "xsl", "xslt", "svg" },
	root_markers = {
		".git",
		"pom.xml",
		"build.gradle",
		"build.gradle.kts",
		"web.xml",
		"*.xsd",
	},
	settings = {
		xml = {
			-- Server settings
			server = {
				workDir = "~/.cache/lemminx",
			},
			-- Completion settings
			completion = {
				autoCloseTags = true,
				autoCloseRemovesContent = false,
			},
			-- Validation settings
			validation = {
				enabled = true,
				namespaces = {
					enabled = "always", -- "always", "never", or "onNamespaceEncountered"
				},
				schema = {
					enabled = "always", -- "always", "never", or "onValidSchema"
				},
				disallowDocTypeDecl = false,
				resolveExternalEntities = false,
			},
			-- Formatting settings
			format = {
				enabled = true,
				splitAttributes = false,
				joinCDATALines = false,
				joinCommentLines = false,
				joinContentLines = false,
				spaceBeforeEmptyCloseTag = true,
				quotations = "doubleQuotes", -- "doubleQuotes" or "singleQuotes"
				preserveAttributeLineBreaks = false,
				preserveEmptyContent = false,
				preservedNewlines = 2,
				maxLineWidth = 0, -- 0 means no limit
				grammarAwareFormatting = true,
			},
			-- Symbol settings
			symbols = {
				enabled = true,
				excluded = {},
				maxItemsComputed = 5000,
				showReferencedGrammars = false,
			},
			-- CodeLens settings
			codeLens = {
				enabled = false,
			},
			-- Hover settings
			hover = {
				enabled = true,
			},
			-- Folding settings
			foldings = {
				includeClosingTagInFold = false,
			},
			-- Preferences
			preferences = {
				includeInlayParameterNameHints = "none", -- "none", "literals", or "all"
				includeInlayPropertyDeclarationTypeHints = false,
				includeInlayVariableTypeHints = false,
				includeInlayFunctionLikeReturnTypeHints = false,
				showSchemaDocumentationType = "all", -- "all", "documentation", or "none"
			},
			-- Catalogs for schema/DTD resolution
			catalogs = {
				-- Add paths to XML catalogs if needed
				-- "path/to/catalog.xml"
			},
			-- Java-specific settings (lemminx runs on Java)
			java = {
				home = nil, -- Will use JAVA_HOME if not set
			},
		},
	},
	single_file_support = true,
	-- Custom initialization options
	init_options = {
		settings = {
			xml = {
				logs = {
					client = true,
					server = true,
				},
				trace = {
					server = "verbose", -- "off", "messages", "verbose"
				},
			},
		},
		extendedClientCapabilities = {
			codeLens = {
				codeLensKind = {
					supported = true,
				},
			},
			actionableNotificationSupported = true,
			openSettingsCommandSupported = true,
		},
	},
}

-- Rust (rust-analyzer)
vim.lsp.config["rust-analyzer"] = {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = {
		"Cargo.toml",
		"Cargo.lock",
		"rust-project.json",
		".git",
	},
	settings = {
		["rust-analyzer"] = {
			-- Import settings
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			-- Cargo settings
			cargo = {
				buildScripts = {
					enable = true,
				},
				allFeatures = true,
				loadOutDirsFromCheck = true,
				runBuildScripts = true,
			},
			-- Procedural macros
			procMacro = {
				enable = true,
				ignored = {},
				attributes = {
					enable = true,
				},
			},
			-- Diagnostics
			diagnostics = {
				enable = true,
				disabled = {},
				remapPrefix = {},
				warningsAsHint = {},
				warningsAsInfo = {},
			},
			-- Lens settings (show references, implementations, etc.)
			lens = {
				enable = true,
				debug = {
					enable = true,
				},
				implementations = {
					enable = true,
				},
				references = {
					adt = {
						enable = false,
					},
					enumVariant = {
						enable = false,
					},
					method = {
						enable = false,
					},
					trait = {
						enable = false,
					},
				},
				run = {
					enable = true,
				},
			},
			-- Inlay hints
			inlayHints = {
				bindingModeHints = {
					enable = false,
				},
				chainingHints = {
					enable = true,
				},
				closingBraceHints = {
					enable = true,
					minLines = 25,
				},
				closureReturnTypeHints = {
					enable = "never",
				},
				lifetimeElisionHints = {
					enable = "never",
					useParameterNames = false,
				},
				maxLength = 25,
				parameterHints = {
					enable = true,
				},
				reborrowHints = {
					enable = "never",
				},
				renderColons = true,
				typeHints = {
					enable = true,
					hideClosureInitialization = false,
					hideNamedConstructor = false,
				},
			},
			-- Completion settings
			completion = {
				callable = {
					snippets = "fill_arguments",
				},
				postfix = {
					enable = true,
				},
				privateEditable = {
					enable = false,
				},
				snippets = {
					custom = {},
				},
			},
			-- Assist settings (code actions)
			assist = {
				importEnforceGranularity = true,
				importPrefix = "plain",
			},
			-- Call hierarchy
			callInfo = {
				full = true,
			},
			-- Check settings (for cargo check)
			checkOnSave = {
				enable = true,
				command = "clippy",
				extraArgs = {},
				allTargets = true,
			},
			-- Highlighting settings
			highlightRelated = {
				breakPoints = {
					enable = true,
				},
				exitPoints = {
					enable = true,
				},
				references = {
					enable = true,
				},
				yieldPoints = {
					enable = true,
				},
			},
			-- Hover settings
			hover = {
				documentation = {
					enable = true,
				},
				links = {
					enable = true,
				},
				memoryLayout = {
					alignment = "hexadecimal",
					enable = false,
					niches = false,
					offset = "hexadecimal",
					size = "both",
				},
			},
			-- Workspace settings
			workspace = {
				symbol = {
					search = {
						scope = "workspace",
						kind = "only_types",
					},
				},
			},
			-- Semantic tokens
			semanticHighlighting = {
				strings = {
					enable = true,
				},
				punctuation = {
					enable = false,
					separate = {
						macro = {
							bang = false,
						},
					},
					specialization = {
						enable = false,
					},
				},
				operator = {
					enable = true,
					specialization = {
						enable = false,
					},
				},
			},
			-- Typing settings
			typing = {
				autoClosingAngleBrackets = {
					enable = false,
				},
			},
			-- Experimental features
			experimental = {
				procAttrMacros = true,
			},
		},
	},
	-- Capabilities for enhanced features
	capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {
		textDocument = {
			completion = {
				completionItem = {
					snippetSupport = true,
					resolveSupport = {
						properties = { "documentation", "detail", "additionalTextEdits" },
					},
				},
			},
		},
		experimental = {
			serverStatusNotification = true,
		},
	}),
	-- Custom initialization options
	init_options = {
		lspMux = {
			version = "1",
			method = "connect",
			server = "rust-analyzer",
		},
	},
	single_file_support = false, -- Rust-analyzer works best with Cargo projects
}
