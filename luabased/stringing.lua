local _M_ = {}
local mathing = require("luabased.mathing")

-- we make some global functions local as this will improve performances in
-- heavy loops.
local tostring = tostring
local select = select
local tableconcat = table.concat
local tableinsert = table.insert
local stringrep = string.rep
local type = type

-- pre-declared objects

--- @class StringFormattingSettings
local StringFormattingSettings = {}

--- The loop-safe string concatenation method.
--- All args passed are converted to string using tostring()
--- @return string
function _M_.conkat(...)
  local buf = {}
  for i = 1, select("#", ...) do
    buf[#buf + 1] = tostring(select(i, ...))
  end
  return tableconcat(buf)
end

--- Same as python's string.split().
--- SRC: https://stackoverflow.com/a/25449599/13806195
--- @param str string
--- @param sep string
--- @return table
function _M_.split(str, sep)
  local result = {}
  local regex = ("([^%s]+)"):format(sep)
  for each in str:gmatch(regex) do
    tableinsert(result, each)
  end
  return result
end


--- Convert the source to a readable string , based on it's type.
--- @param source any any type
--- @param index number recursive level of stringify
--- @param settings StringFormattingSettings|nil configure how source is formatted
--- @return string
function _M_.stringify(source, index, settings)

  if not settings then
    settings = StringFormattingSettings:new()
  end

  if not index then
    index = 0
  end

  if (type(source) == "table") then
    source = _M_.table2string(source, index, settings)

  elseif (type(source) == "number") then
    source = tostring(mathing.round(source, settings.numbers.round))

  elseif (type(source) == "string") and settings.strings.display_quotes == true then
    source = _M_.conkat("\"", source, "\"")

  elseif (type(source) == "string") then
    -- do nothing

  else
    source = tostring(source)

  end

  return source

end


--- Convert a table to human readable string.
--- By default formatted on multiples lines for clarity. Specify tdtype=oneline
---   to get no line breaks.
--- If the key is a number, only the value is kept.
--- If the key is something else, it is formatted to "stringify(key)=stringify(value),"
--- If the table is too long (max_length), it is formatted as oneline
--- @param tablevalue table table to convert to string
--- @param index number recursive level of conversions used for indents
--- @param settings StringFormattingSettings|nil Configure how table are displayed.
--- @return string
function _M_.table2string(tablevalue, index, settings)

  -- check if table is empty
  if next(tablevalue) == nil then
    return "{}"
  end

  -- if no index specified recursive level is 0 (first time)
  if not index then
    index = 0
  end

  local tsettings
  if settings and settings.tables then
    tsettings = settings.tables
  else
    tsettings = StringFormattingSettings:new().tables
  end

  local linebreak_start = "\n"
  local linebreak = "\n"
  local inline_indent = stringrep(
      " ", index * tsettings.indent + tsettings.indent
  )
  local inline_indent_end = stringrep(
      " ", index * tsettings.indent
  )

  -- if the table is too long make it one line with no line break
  if #tablevalue > tsettings.length_max then
    linebreak = ""
    inline_indent = ""
    inline_indent_end = ""
  end
  -- if specifically asked for the table to be displayed as one line
  if tsettings.linebreaks == false then
    linebreak = ""
    linebreak_start = ""
    inline_indent = ""
    inline_indent_end = ""
  end

  -- to avoid string concatenation in loop using a table
  local outtable = {}
  outtable[#outtable + 1] = "{"
  outtable[#outtable + 1] = linebreak_start

  for k, v in pairs(tablevalue) do
    -- if table is build with number as keys, just display the value
    if (type(k) == "number") and tsettings.display_indexes == false then
      outtable[#outtable + 1] = inline_indent
      outtable[#outtable + 1] = _M_.stringify(v, index + 1, settings)
      outtable[#outtable + 1] = ","
      outtable[#outtable + 1] = linebreak
    else

      if (type(v) == "function") and tsettings.display_functions == false then
        outtable[#outtable + 1] = ""
      else
        outtable[#outtable + 1] = inline_indent
        outtable[#outtable + 1] = _M_.stringify(k, index + 1, settings)
        outtable[#outtable + 1] = "="
        outtable[#outtable + 1] = _M_.stringify(v, index + 1, settings)
        outtable[#outtable + 1] = ","
        outtable[#outtable + 1] = linebreak
      end

    end
  end
  outtable[#outtable + 1] = inline_indent_end
  outtable[#outtable + 1] = "}"
  return tostring(tableconcat(outtable))

end


--- A base class that hold configuration settings for string formatting used
---  by stringify() and table2string()
function StringFormattingSettings:new()

  -- these are the default values
  local attrs = {
    ["numbers"] = {
      -- how much decimals should be kept for floating point numbers
      ["round"] = 3
    },
    ["tables"] = {
      -- how much whitespaces is considered an indent
      ["indent"] = 4,
      -- max table size before displaying it as oneline to avoid flooding
      ["length_max"] = 50,
      -- true to display the table on multiples lines with indents
      ["linebreaks"] = true,
      ["display_indexes"] = false,
      ["display_functions"] = true
    },
    ["strings"] = {
      ["display_quotes"] = false
    }
  }

  --- @param enable boolean true to enable blocking of repeated messages
  function attrs:set_blocks_duplicate(enable)
    self.blocks_duplicate = enable
  end

    --- @param round_value number
  function attrs:set_num_round(round_value)
    self.numbers.round = round_value
  end

    --- @param display_value boolean
  function attrs:set_str_display_quotes(display_value)
    self.strings.display_quotes = display_value
  end

  --- @param display_value boolean
  function attrs:set_tbl_display_indexes(display_value)
    self.tables.display_indexes = display_value
  end

  --- @param display_value boolean
  function attrs:set_tbl_linebreaks(display_value)
    -- display_value(bool):
    self.tables.linebreaks = display_value
  end

  --- @param length_max number
  function attrs:set_tbl_length_max(length_max)
    self.tables.length_max = length_max
  end

  --- @param indent number
  function attrs:set_tbl_indent(indent)
    self.tables.indent = indent
  end

  --- @param display_value boolean
  function attrs:set_tbl_display_functions(display_value)
    self.tables.display_functions = display_value
  end

  return attrs

end


return _M_