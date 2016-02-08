fractalmap = {}
fractalmap.mod_path = minetest.get_modpath("fractalmap")

-- Define the function called just before the Minetest mapgen is activated
minetest.register_on_mapgen_init(function(mgparams)
	if mgparams.mgname ~= "singlenode" then
		print("[fractalmap] Set mapgen to singlenode")
		-- Single mode mapgen: no blocks, just air.
		minetest.set_mapgen_params({mgname="singlenode"})
	end
end)

-- regenerate was copied from yappy, does not work (yet)
minetest.register_chatcommand("regenerate", {
	description = "Regenerates <size * 8>^3 nodes around you",
	params = "<size * 8>",
	privs = {server=true},
	func = function(name, param)
		local size = tonumber(param) or 1

		if size > 8 then
			size = 8 -- Limit: 8*8 -> 64
		elseif size < 1 then
			return false, "Nothing to do."
		end

		size = size * 8
		local player = minetest.get_player_by_name(name)
		local pos = vector.floor(vector.divide(player:getpos(), size))
		local minp = vector.multiply(pos, size)
		local maxp = vector.add(minp, size - 1)

		minetest.generate(minp, maxp, math.random(0, 9999), true)
		return true, "Done!"
	end
})



-- Load fractalmap.generate function 
--Load only one the following mapgens:

--= Load the Sierpinski Carpet fractal mapgen. ==--
--dofile(fractalmap.mod_path.."/sierpinski.lua")


--= Load the newton fractal mapgen (not working yet). ==--
dofile(fractalmap.mod_path.."/newton.lua")


--Load only one the previous mapgens.




-- Add the generate function to minetest ??
-- Copied from Yappy, not if this does what I think...
table.insert(minetest.registered_on_generateds, 1, fractalmap.generate)
