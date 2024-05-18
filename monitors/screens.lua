local screens = {}
local primary = "DP-0"
local left    = "HDMI-0"
local right   = "DVI-D-0"

for s in screen do
  local randr_table = pairs(s.outputs)
  local monitor_name, _ = randr_table(s.outputs)
    if monitor_name == primary then
      screens.primary = s
    elseif monitor_name == left then
      screens.left = s
    elseif monitor_name == right then
      screens.right = s
    end
end

return screens
