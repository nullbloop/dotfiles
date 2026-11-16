return {
	'RRethy/base16-nvim',
	enabled = false,
	config = function()
		local ok, matugen = pcall(require, 'matugen')
		if ok then matugen.setup() end
	end,
}
