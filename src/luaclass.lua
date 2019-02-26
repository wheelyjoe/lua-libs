-- Taken from DCS Script directory and modified to not be a sealed
-- class
-- Provides mechanism like C++ classes and objects

--Lua-class metatable
local LuaClass = {
	--Provides access to functions in parent class
	__index = function(class, funcName)
		local parentClass = rawget(class, 'parentClass_')
		if parentClass ~= nil then
			return parentClass[funcName]
		else
			assert(false, 'Function '..funcName..' not found')
		end
	end,
}

--Dumy base class for all classes
local voidClass = {
	className_ = 'void',
	parentClass = nil
}

--Declares tbl as class with parent (multiple inheritance not allowed)
local function class(tbl, parent)
	parent = parent or voidClass
	tbl.className_ = tbl.className_ or 'unknown ('..tostring(tbl)..')'
	tbl.__index = tbl
	assert(tbl ~= parent)
	tbl.parentClass_ = parent
	setmetatable(tbl, LuaClass)
end

return class
