--[[
Global test file to just see if the package works.
Not a proper test.
]]

local luabased = require("luabased")

local r

r = luabased.formatting.conkat("I'm ", "Working")
assert(r, "luabased.formatting.conkat failed")

r = luabased.mathing.round(0.978564123, 3)
assert(r, "luabased.mathing.round failed")