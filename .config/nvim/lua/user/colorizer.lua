local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
  return
end

colorizer.setup({
	"*", -- Highlight all files, but customize some others.
	css = { rgb_fn = true }, -- Enable parsing rgb(...) functions in css.
	html = { names = false }, -- Disable parsing "names" like Blue or Gray
})
