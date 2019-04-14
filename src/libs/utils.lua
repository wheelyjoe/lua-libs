local utils = {}

function utils.foreach(array, itr, fcn, ctx)
	for k, v in itr(array) do
		fcn(k, v, ctx)
	end
end

return utils

--[[
function utils.debug(str)
	if debug == nil then
		return
	end
	print("DEBUG: "..str)
end
--]]
