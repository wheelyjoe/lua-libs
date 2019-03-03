local function class(base)
	base = base or nil
	local newcls = {}
	local cls_mt = {
		__call = function(cls)
			local obj = {}
			setmetatable(obj, { __index = cls })
			return obj
		end,
		__index = newcls,
	}

	setmetatable(newcls, cls_mt)
	if nil ~= base then
		setmetatable(newcls, { __call = cls_mt.__call, __index = base })
	end

	function newcls:class()
		return newcls
	end

	function newcls:super()
		return base
	end

	-- Return true if the caller is an instance of theClass
	function newcls:isa(other)
		local b_isa = false
		local cur_class = newcls

		while ( nil ~= cur_class ) and ( false == b_isa ) do
			if cur_class == other then
				b_isa = true
			else
				cur_class = cur_class:super()
			end
		end
		return b_isa
	end

	return newcls
end

return class
