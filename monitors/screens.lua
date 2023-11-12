local screens = {}

local primary = "DP-0"
local left    = "HDMI-0"
local right   = "DVI-D-0"

for s in screen do
  for key, value in pairs(s.outputs) do
    local tmp = tostring(key)
    if tmp == primary then
      screens.primary = s
    elseif tmp == left then
      screens.left = s
    else
      screens.right = s
    end
  end
end

return screens
