
-- SPDX-License-Identifier: LGPL-3.0

local utils = {}

function utils.foreach(ctx, itr, fcn, array, arg)
	for k, v in itr(array) do
		fcn(ctx, k, v, arg)
	end
end

function utils.shallowclone(obj)
	local obj_type = type(obj)
	local copy

	if obj_type == 'table' then
		copy = {}
		for k,v in pairs(obj) do
			copy[k] = v
		end
	else
		copy = obj
	end
	return copy
end

function utils.deepcopy(obj)
	local obj_type = type(obj)
	local copy

	if obj_type == 'table' then
		copy = {}
		for k,v in next, obj, nil do
			copy[k] = utils.deepcopy(v)
		end
	else
		copy = obj
	end
	return copy
end

function utils.mergetables(dest, source)
	assert(type(dest) == "table", "dest must be a table")
	for k, v in pairs(source or {}) do
		dest[k] = v
	end
	return dest
end

-- return the directory seperator used for the given OS
utils.sep = package.config:sub(1,1)

return utils
