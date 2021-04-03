codes = true
std   = "lua51"
jobs  = 3
self  = false
max_cyclomatic_complexity = 10
read_globals = {
	-- common lua globals
	"lfs",
	"md5",
}
exclude_files = {
	"src/libs/json.lua",
}
