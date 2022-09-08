local _M_ = {}


function _M_.hsv(color, h, s, v)
  --[[
  Credit <colour-science> and <Easyrgb>.

  Args:
    color(table): r, g and b channel as a table
    h(num): hue ; 0-1 range; 1 for no effect
    s(num): saturation; 0-1 range; 1 for no effect
    v(num): value; 0-1 range; 1 for no effect
  ]]

  local r = color[1]
  local g = color[2]
  local b = color[3]

  -- 1. RGB to HSV
  local ch
  local cs
  local cv

  local d1
  local da
  local db
  local dc

  local hx

  cv = math.max(r,g,b)
  d1 = cv - math.min(r,g,b)  -- delta

  cs = d1 / cv
  if d1 == 0 then
    cs = 0
  end

  da = (((cv - r) / 6) + (d1 / 2)) / d1
  db = (((cv - g) / 6) + (d1 / 2)) / d1
  dc = (((cv - b) / 6) + (d1 / 2)) / d1

  ch = dc - db
  if g == cv then
    ch = (1 / 3) + da - dc
  end
  if b == cv then
    ch = (2 / 3) + db - da
  end
  if ch < 0 then
    ch = ch + 1
  end
  if ch > 1 then
    ch = ch - 1
  end
  if d1 == 0 then
    ch = 0
  end

  -- 2. Apply per-channel modification
  ch = ch * h
  cs = cs * s
  cv = cv * v

  -- 3. HSV to RGB
  hx = ch * 6
  if hx == 6 then
    hx = 0
  end

  d1 = math.floor(hx)
  da = cv * (1 - cs)
  db = cv * (1 - cs * (hx - d1))
  dc = cv * (1 - cs * (1-(hx - d1)))

  if d1 == 0 then
    r = cv
    g = dc
    b = da
  elseif d1 == 1 then
    r = db
    g = cv
    b = da
  elseif d1 == 2 then
    r = da
    g = cv
    b = dc
  elseif d1 == 3 then
    r = da
    g = db
    b = cv
  elseif d1 == 4 then
    r = dc
    g = da
    b = cv
  else
    r = cv
    g = da
    b = db
  end

  return { r, g, b }

end


return _M_