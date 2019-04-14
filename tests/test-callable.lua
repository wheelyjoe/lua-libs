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

	return 0
end
os.exit(test())
