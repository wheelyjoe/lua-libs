--[[
local function callable(cls)
	local inst = {}
	for k,v in pairs(cls) do
		inst[k] = v
	end
	setmetatable(inst, { __index = cls.__index })
	return inst
end
--]]

local function callable(cls)
	local inst = {}
	setmetatable(inst, {__index = cls})
	return inst
end

local baseclass = {
	__call  = callable,
	parent = function(self)
		local p = getmetatable(self)
		if nil == p then
			return p
		end
		p = getmetatable(p.__index)
		if nil == p then
			return p
		end
		return p
	end,
}

local function class(cls, parent)
	parent = parent or baseclass
	cls.classname_ = cls.classname_ or 'unknown ('..tostring(tbl)..')'
	cls.__call  = callable
	cls.__index = parent
	setmetatable(cls, parent)
end

return class
