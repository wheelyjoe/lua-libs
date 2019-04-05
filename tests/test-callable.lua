require("os")

local function callable(cls)
	local inst = {}
	setmetatable(inst, { __index = cls })
	return inst
end

function test()
	local A = {
		__call = callable,
	}
	setmetatable(A, A)

	local B = {}
	setmetatable(B, { __call = callable })

	local a = A()
	local b = B()

	return true
end

r = "Failed"
rc = 1
if test() then
	r = "Passed"
	rc = 0
end
print(string.format("%s - Callable Test", r))
os.exit(rc)
