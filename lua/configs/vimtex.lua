local present, vimtex = pcall(require, "vimtex")

if not present then
	return
end

vimtex.setup({
	vimtex_view_method = "zathura",
	maplocalleader = ",",
})
