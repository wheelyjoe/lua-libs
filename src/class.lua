local function shallowclone(tbl)
	local t = {}

	if tbl == nil then
		return t
	end
	for k,v in pairs(tbl) do
		t[k] = v
	end
	return t
end

local function class(base)
	local newcls = shallowclone(base)
	local cls_mt = {
		__call = function(cls, ...)
			local c = shallowclone(cls)
			if type(c.__init) == "function" then
				c.__init(c, ...)
			end
			return c
		end,
	}

	function newcls:super()
		return base
	end

	function newcls:isa(other)
		local b_isa = false
		local cur_class = newcls

		while nil ~= cur_class and false == b_isa do
			if cur_class == other then
				b_isa = true
			else
				cur_class = cur_class:super()
			end
		end
		return b_isa
	end

	setmetatable(newcls, cls_mt)
	return newcls
end

return class
