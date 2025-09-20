require("nvchad.mappings")
local dapui = require("dapui")
dapui.setup() -- Make sure DAP UI is properly set up
local map = vim.keymap.set

-- Diagnostics Toggle Function
local M = {}
local errors_only_mode = false

M.toggle_diagnostics = function()
	if errors_only_mode then
		-- Currently showing errors only, show all
		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			underline = true,
		})
		errors_only_mode = false
		print("Showing all diagnostics")
	else
		-- Show errors only
		vim.diagnostic.config({
			virtual_text = { severity = { min = vim.diagnostic.severity.ERROR } },
			signs = { severity = { min = vim.diagnostic.severity.ERROR } },
			underline = { severity = { min = vim.diagnostic.severity.ERROR } },
		})
		errors_only_mode = true
		print("Showing errors only")
	end
end

map("n", ";", ":", { desc = "CMD enter command mode" })

-- Diagnostics Toggle
map("n", "<leader>td", M.toggle_diagnostics, { desc = "Toggle diagnostics level" })

-- Spell checking keymaps
map("n", "<leader>s", function()
	vim.opt.spell = not vim.opt.spell:get()
end, { desc = "Toggle spell check" })

map("n", "]s", "]s", { desc = "Next misspelled word" })

map("n", "[s", "[s", { desc = "Previous misspelled word" })

map("n", "z=", "z=", { desc = "Suggest corrections" })

map("n", "zg", "zg", { desc = "Add word to dictionary" })

map("n", "zw", "zw", { desc = "Mark word as incorrect" })

-- LSP Core Functions (including code generation for missing methods)
map("n", "<leader>ca", function()
	vim.lsp.buf.code_action()
end, { desc = "LSP Code Actions (Generate Missing Methods)" })
map("n", "<leader>rn", function()
	vim.lsp.buf.rename()
end, { desc = "LSP Rename Symbol" })
map("n", "<leader>gd", function()
	vim.lsp.buf.definition()
end, { desc = "LSP Go to Definition" })
map("n", "<leader>gD", function()
	vim.lsp.buf.declaration()
end, { desc = "LSP Go to Declaration" })
map("n", "<leader>gi", function()
	vim.lsp.buf.implementation()
end, { desc = "LSP Go to Implementation" })
map("n", "<leader>gr", function()
	vim.lsp.buf.references()
end, { desc = "LSP Find References" })
map("n", "<leader>K", function()
	vim.lsp.buf.hover()
end, { desc = "LSP Hover Documentation" })
map("n", "<leader>k", function()
	vim.lsp.buf.signature_help()
end, { desc = "LSP Signature Help" })
map("n", "<leader>D", function()
	vim.lsp.buf.type_definition()
end, { desc = "LSP Type Definition" })
map("n", "<leader>wa", function()
	vim.lsp.buf.add_workspace_folder()
end, { desc = "LSP Add Workspace Folder" })
map("n", "<leader>wr", function()
	vim.lsp.buf.remove_workspace_folder()
end, { desc = "LSP Remove Workspace Folder" })
map("n", "<leader>wl", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "LSP List Workspace Folders" })

-- Conform.nvim Formatting (replaces LSP formatting)
map("n", "<leader>f", function()
	require("conform").format({
		lsp_fallback = true,
		async = true,
		timeout_ms = 1000,
	})
end, { desc = "Format Document with Conform" })
map("v", "<leader>f", function()
	require("conform").format({
		lsp_fallback = true,
		async = true,
		timeout_ms = 1000,
	})
end, { desc = "Format Selection with Conform" })

-- Alternative: If you want to keep LSP formatting as backup, use different keybinding
map("n", "<leader>lf", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "LSP Format Document" })

-- Trouble
map("n", "<leader>qx", "<cmd>TroubleToggle<CR>", { desc = "Open Trouble" })
map("n", "<leader>qw", "<cmd>TroubleToggle workspace_diagnostics<CR>", { desc = "Open Workspace Trouble" })
map("n", "<leader>qd", "<cmd>TroubleToggle document_diagnostics<CR>", { desc = "Open Document Trouble" })
map("n", "<leader>qq", "<cmd>TroubleToggle quickfix<CR>", { desc = "Open Quickfix" })
map("n", "<leader>ql", "<cmd>TroubleToggle loclist<CR>", { desc = "Open Location List" })
map("n", "<leader>qt", "<cmd>TodoTrouble<CR>", { desc = "Open Todo Trouble" })

-- Java Development
map("n", "<leader>jo", function()
	require("jdtls").organize_imports()
end, { desc = "Organize Imports" })
map("n", "<leader>jv", function()
	require("jdtls").extract_variable()
end, { desc = "Extract Variable" })
map("n", "<leader>jc", function()
	require("jdtls").extract_constant()
end, { desc = "Extract Constant" })
map("n", "<leader>jm", function()
	require("jdtls").extract_method()
end, { desc = "Extract Method" })

-- Java Debugging & Testing (JDTLS)
map("n", "<leader>jd", function()
	require("jdtls.dap").setup_dap_main_class_configs()
end, { desc = "JDTLS: Setup Main Class DAP Configs" })
map("n", "<leader>jt", function()
	require("jdtls.dap").test_class()
end, { desc = "JDTLS: Debug Test Class" })
map("n", "<leader>jn", function()
	require("jdtls.dap").test_nearest_method()
end, { desc = "JDTLS: Debug Nearest Test Method" })
map("n", "<leader>jg", function()
	require("jdtls.tests").generate()
end, { desc = "JDTLS: Generate Test Class" })
map("n", "<leader>js", function()
	require("jdtls.tests").goto_subjects()
end, { desc = "JDTLS: Go To Related Subjects" })

-- Tests
map("n", "<leader>tt", function()
	require("neotest").run.run()
end, { desc = "Test Nearest" })
map("n", "<leader>tf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Test File" })
map("n", "<leader>ts", function()
	require("neotest").summary.toggle()
end, { desc = "Test Summary" })
map("n", "<leader>to", function()
	require("neotest").output.open({ enter = true })
end, { desc = "Test Output" })

-- Debug
map("n", "<leader>dc", function()
	require("dap").continue()
end, { desc = "Debug Continue" })
map("n", "<leader>do", function()
	require("dap").step_over()
end, { desc = "Debug Step Over" })
map("n", "<leader>di", function()
	require("dap").step_into()
end, { desc = "Debug Step Into" })
map("n", "<leader>du", function()
	require("dap").step_out()
end, { desc = "Debug Step Out" })
map("n", "<leader>db", function()
	require("dap").toggle_breakpoint()
end, { desc = "Debug Toggle Breakpoint" })
map("n", "<leader>dB", function()
	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Debug Conditional Breakpoint" })
map("n", "<leader>dt", function()
	require("dapui").toggle()
end, { desc = "Debug UI Toggle" })
map("n", "<leader>lD", function() end)

-- Git
map("n", "<leader>gl", ":Flog<CR>", { desc = "Git Log" })
map("n", "<leader>gf", ":DiffviewFileHistory<CR>", { desc = "Git File History" })
map("n", "<leader>gc", ":DiffviewOpen HEAD~1<CR>", { desc = "Git Last Commit" })
map("n", "<leader>gt", ":DiffviewToggleFile<CR>", { desc = "Git File History" })
map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Git Preview Hunk" })
map("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Git Toggle Current Line Blame" })

-- Terminal
map("n", "<C-/>", function()
	require("nvchad.term").toggle({ pos = "sp", size = 0.3 })
end, { desc = "Toggle Terminal Horizontal" })
map("t", "<C-/>", function()
	require("nvchad.term").toggle({ pos = "sp" })
end, { desc = "Toggle Terminal Horizontal" })

-- Spring Boot Plugin Keybindings
map("n", "<leader>sr", function()
	require("springboot-nvim").boot_run()
end, { desc = "Spring Boot Run" })
map("n", "<leader>ss", function()
	require("springboot-nvim").boot_stop()
end, { desc = "Spring Boot Stop" })
map("n", "<leader>sc", function()
	require("springboot-nvim").generate_class()
end, { desc = "Spring Create Class" })
map("n", "<leader>si", function()
	require("springboot-nvim").generate_interface()
end, { desc = "Spring Create Interface" })
map("n", "<leader>se", function()
	require("springboot-nvim").generate_enum()
end, { desc = "Spring Create Enum" })
map("n", "<leader>sp", function()
	require("springboot-nvim").generate_application_properties()
end, { desc = "Spring Generate Application Properties" })
map("n", "<leader>sd", function()
	require("springboot-nvim").generate_dto()
end, { desc = "Spring Generate DTO" })
map("n", "<leader>sC", function()
	require("springboot-nvim").generate_controller()
end, { desc = "Spring Generate Controller" })
map("n", "<leader>sS", function()
	require("springboot-nvim").generate_service()
end, { desc = "Spring Generate Service" })
map("n", "<leader>sR", function()
	require("springboot-nvim").generate_repository()
end, { desc = "Spring Generate Repository" })
map("n", "<leader>sE", function()
	require("springboot-nvim").generate_entity()
end, { desc = "Spring Generate Entity" })

-- Additional Spring Boot utilities
map("n", "<leader>sb", function()
	require("springboot-nvim").generate_boot_run()
end, { desc = "Spring Boot Generate Run Config" })
map("n", "<leader>st", function()
	require("springboot-nvim").generate_test()
end, { desc = "Spring Generate Test" })

-- URL
map("n", "gx", "<cmd>URLOpenUnderCursor<cr>")

-- Open a note in the Obsidian app
map("n", "<leader>oo", "<cmd>ObsidianOpen<cr>", { desc = "Open in Obsidian App" })
-- Search for or create notes
map("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Obsidian Quick Switch" })
-- Follow a link under your cursor
map("n", "<leader>of", "<cmd>ObsidianFollowLink<cr>", { desc = "Obsidian Follow Link" })
-- Go back to your last note
map("n", "<leader>ob", "<cmd>ObsidianBacklinks<cr>", { desc = "Obsidian Back Links" })
-- Search for notes in a sub-folder
map("n", "<leader>os", "<cmd>ObsidianSearch<cr>", { desc = "Obsidian Search" })
-- Open today's daily note
map("n", "<leader>ot", "<cmd>ObsidianToday<cr>", { desc = "Obsidian Today" })
-- Open tomorrow's daily note
map("n", "<leader>om", "<cmd>ObsidianTomorrow<cr>", { desc = "Obsidian Tomorrow" })
-- Open yesterday's daily note
map("n", "<leader>oy", "<cmd>ObsidianYesterday<cr>", { desc = "Obsidian Yesterday" })
-- Create a new note from a template
map("n", "<leader>oT", "<cmd>ObsidianTemplate<cr>", { desc = "Obsidian Template" })
-- Paste an image from the clipboard
map("n", "<leader>op", "<cmd>ObsidianPasteImg<cr>", { desc = "Obsidian Paste Image" })
-- Rename the note of the current buffer or reference under the cursor
map("n", "<leader>or", "<cmd>ObsidianRename<cr>", { desc = "Obsidian Rename" })
-- Create a new note and link it under the cursor
map("n", "<leader>ol", "<cmd>ObsidianLink<cr>", { desc = "Obsidian Link" })
-- Create a new note in a specific location and link it under the cursor
map("n", "<leader>oL", "<cmd>ObsidianLinkNew<cr>", { desc = "Obsidian Link New" })
-- Extract the current selection into a new note and link to it
map("v", "<leader>oe", "<cmd>ObsidianExtractNote<cr>", { desc = "Obsidian Extract Note" })
-- Navigate to/from daily notes
map("n", "<leader>otd", "<cmd>ObsidianDailies<cr>", { desc = "Obsidian Daily Notes" })
-- Show all tags
map("n", "<leader>ogt", "<cmd>ObsidianTags<cr>", { desc = "Obsidian Tags" })
-- Workspace switcher (if you have multiple workspaces)
map("n", "<leader>ow", "<cmd>ObsidianWorkspace<cr>", { desc = "Obsidian Switch Workspace" })

-- NOTIFY
map("n", "<leader>cn", function()
	require("notify").clear_history()
end)

-- Paste image
map("n", "<leader>p", function()
	require("img-clip").paste_image()
end, { desc = "Paste image from the clipboard" })

-- Basic
map("i", "jj", "<ESC>")

map("i", "<C-f>", function()
	return vim.fn["codeium#Accept"]()
end, { expr = true })

map("n", "<leader><leader>", "<CMD>w<CR>")

map("n", "<leader>q", "<CMD>qa<CR>")

map("n", "<leader>1", "<CMD>qa!<CR>")

-- Ints mappings
map("x", "<leader>p", [["_dP]])
