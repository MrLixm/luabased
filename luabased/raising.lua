local _M_ = {}

local stringing = require("luabased.stringing")


function _M_.errorc(...)
  --[[
  Concatened error. Arguments are string concatened together to be used
  as error's message.
  ]]
  error(stringing.conkat(...))
end

return _M_