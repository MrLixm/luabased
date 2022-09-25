local _M_ = {}

-- we make some global functions local as this will improve performances in
-- heavy loops.
local mathpi = math.pi
local mathfloor = math.floor
local stringformat = string.format

--- Converts the given float to an integer representation.
--- SRC: https://stackoverflow.com/questions/9654496/lua-converting-from-float-to-int
--- @param a number float to convert
--- @param prec number float to convert
function _M_.toint(a, prec)
  return mathfloor(a + 0.5 * prec) -- where prec is 10^n, starting at 0
end

--- Round the given float to the given number of decimal after the separator.
--- SRC: http://lua-users.org/wiki/SimpleRound
--- @param num number number to round
--- @param numDecimalPlaces number number of decimal to keep
function _M_.round(num, numDecimalPlaces)
  return tonumber(stringformat("%." .. (numDecimalPlaces or 0) .. "f", num))
end


--- @param rotation number rotation value to convert to radian
--- @return number rotation value converted to radian
function _M_.degree_to_radian(rotation)
  return rotation * (mathpi / 180.0)
end

--- @param radian number radian value to convert to degree
--- @return number radian value converted to degree
function _M_.radian_to_degree(radian)
  return radian * (180.0 / mathpi)
end


return _M_