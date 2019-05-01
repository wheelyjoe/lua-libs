
-- SPDX-License-Identifier: LGPL-3.0

local utils = {}

function utils.foreach(array, itr, fcn, ctx)
	for k, v in itr(array) do
		fcn(k, v, ctx)
	end
end

function utils.shallowclone(tbl)
	local t = {}

	if tbl == nil then
		return t
	end
	for k,v in pairs(tbl) do
		t[k] = v
	end
	return t
end

-- return the directory seperator used for the given OS
utils.sep = package.config:sub(1,1)

return utils
