fractalmap = {}
fractalmap.mod_path = minetest.get_modpath("fractalmap")


--Load only one the following mapgens:

--= Load the Sierpinski Carpet fractal mapgen. ==--
dofile(fractalmap.mod_path.."/sierpinski.lua")


--= Load the newton fractal mapgen (not working yet). ==--
--dofile(fractalmap.mod_path.."/newton.lua")


--Load only one the previous mapgens.

