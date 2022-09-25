local _M_ = {}

local stringing = require("luabased.stringing")


--- Concatened error. Arguments are string concatened together to be used
--- as error's message.
function _M_.errorc(...)
  error(stringing.conkat(...))
end

return _M_