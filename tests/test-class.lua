require("os")

local class = require("class")

function test()
	local A = class()
	function A:exec()
		return "A"
	end

	local B = class(A)
	function B:exec()
		local s = ""
		s = s .. self:super():exec()
		s = s .. "B"
		return s
	end

	local C = class(B)
	function C:exec()
		local s = ""
		s = s .. self:super():exec()
		s = s .. "C"
		return s
	end

	local J = class()

	local a = A()
	assert(a:exec() == "A")

	local b = B()
	assert(b:exec() == "AB")

	local c = C()
	assert(c:exec() == "ABC")
	assert(c:isa(C))
	assert(c:isa(A))
	assert(not c:isa(J))

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
