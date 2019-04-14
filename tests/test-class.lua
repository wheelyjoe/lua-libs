require("os")

local class = require("libs.class")

function printtable(t)
	print("name: ", t.__name)
	for k,v in pairs(t) do
		print("index: ", k, "value: ", v, "type: ", type(v))
	end
end

function test()
	local A = class()
	function A:__init(v)
		self.val = v
		self.__name = "A"
	end
	function A:exec()
		self.val = self.val + 1
		return "A"
	end

	local B = class(A)
	function B:__init(v)
		A.__init(self, v)
		self.__name = "B"
	end
	function B:exec()
		local s = ""
		s = s .. A.exec(self)
		s = s .. "B"
		return s
	end

	local C = class(B)
	function C:__init(v)
		B.__init(self, v)
		self.__name = "C"
	end
	function C:exec()
		local s = ""
		s = s .. B.exec(self)
		s = s .. "C"
		return s
	end

	local J = class()

	local a = A(2)
	--printtable(a)
	assert(a:exec() == "A")
	assert(a.val == 3)

	local b = B(3)
	--printtable(b)
	assert(b:exec() == "AB")
	assert(b.val == 4)
	--printtable(b)
	assert(a.val == 3)

	local c = C(5)
	assert(c:exec() == "ABC")
	assert(c:isa(C))
	assert(c:isa(A))
	assert(not c:isa(J))
	--printtable(c)

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
