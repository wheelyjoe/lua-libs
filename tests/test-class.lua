require("os")

local class = require("luaclass")

function printtable(t)
	for k,v in pairs(t) do
		print("key: ", k, "val: ", v, "type: ", type(v))
	end
end

function test()
	local A = {
		classname_ = "A",
	}
	function A:exec()
		--print("A:exec()")
		return "A"
	end
	class(A)

	local B = {
		classname_ = "B",
	}
	function B:exec()
		--print("B:exec()")
		local parent = self:parent()
		local s = ""
		if type(parent.exec) == "function" then
			s = s .. parent:exec()
			--print("first: '" .. s .. "'")
		end
		s = s .. "B"
		--print("second: '" .. s .. "'")
		return s
	end
	class(B, A)

	local a = A()
	local b = B()

	--print("a:")
	--printtable(a)
	--print("metatable(a):")
	--printtable(getmetatable(a))
	--print("metatable(a).__index:")
	--printtable(getmetatable(a).__index)
	--print("metatable(metatable(a).__index):")
	--printtable(getmetatable(getmetatable(a).__index))
	--print("==============")
	--print("b:")
	--printtable(b)
	--print("metatable(b):")
	--printtable(getmetatable(b))
	--print("metatable(b).__index:")
	--printtable(getmetatable(b).__index)
	--print("metatable(metatable(b).__index):")
	--printtable(getmetatable(getmetatable(b).__index))

	b:exec()
	a:exec()

	assert(a:exec() == "A")
	assert(b:exec() == "AB")

	return true
end

r = "Failed"
rc = 1
if test() then
	r = "Passed"
	rc = 0
end
print(string.format("%s - Class Inheritance Test", r))
os.exit(rc)
