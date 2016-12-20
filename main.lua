baton  = require "baton"
hotkey = require "combo"

love.load = function()
  local controls = {
    left = {'key:left', 'axis:leftx-', 'button:dpleft'},
    right = {'key:right', 'axis:leftx+', 'button:dpright'},
    up = {'key:up', 'axis:lefty-', 'button:dpup'},
    down = {'key:down', 'axis:lefty+', 'button:dpdown'},
    shoot = {'key:x', 'button:a'},

    a = {'key:a'},
    w = {'key:w'},
    d = {'key:d'},
  }

  input = baton.new(controls, love.joystick.getJoysticks()[1])

  simple = hotkey.new{
    {"subweapon", {"up", "shoot"}, {"right"}, {"shoot"}},
    {"subweapon", {"down", "shoot"}, {"right"}, {"shoot"}},

    {"awd", {"a", "w", "d"}},

    {"dw", {"d", "w"}, {"a"}, {"w"}},
    {"da", {"d", "a"}, {"w"}, {"a"}},
    {"wd", {"w", "d"}, {"a"}, {"d"}},
    {"wa", {"w", "a"}, {"d"}, {"a"}},
    {"aw", {"a", "w"}, {"d"}, {"w"}},
    {"ad", {"a", "d"}, {"w"}, {"d"}},

    {"a", {"a"}, {"w", "d"}},
    {"w", {"w"}, {"a", "d"}},
    {"d", {"d"}, {"a", "w"}},
  }

  simple.isDown    = isDown
  simple.isPressed = isPressed

  states = {}
  states.down = {}
end

isDown = function(key)
  return input:down(key)
end

isPressed = function(key)
  return input:pressed(key)
end

function love.update(dt)
  input:update()
  simple:update()

  states.down = simple.down

  if simple.released.aw then
    print("AW released")
  end

  if simple.pressed.subweapon then
    print("AXE!")
  end
end

love.draw = function()
  love.graphics.print("A   "..tostring(states.down.a), 0, 0)
  love.graphics.print("W   "..tostring(states.down.w), 0, 12)
  love.graphics.print("D   "..tostring(states.down.d), 0, 24)
  love.graphics.print("AW  "..tostring(states.down.aw), 0, 36)
  love.graphics.print("AD  "..tostring(states.down.ad), 0, 48)
  love.graphics.print("WD  "..tostring(states.down.wd), 0, 60)
  love.graphics.print("WA  "..tostring(states.down.wa), 0, 72)
  love.graphics.print("DW  "..tostring(states.down.dw), 0, 84)
  love.graphics.print("DA  "..tostring(states.down.da), 0, 96)
  love.graphics.print("AWD "..tostring(states.down.awd), 0, 108)

  if states.down.w  then love.graphics.circle("fill", 370, 125, 10) end
  if states.down.wa then love.graphics.circle("fill", 320, 215, 10) end
  if states.down.wd then love.graphics.circle("fill", 420, 215, 10) end
  if states.down.aw then love.graphics.circle("fill", 245, 340, 10) end
  if states.down.dw then love.graphics.circle("fill", 490, 345, 10) end
  if states.down.a  then love.graphics.circle("fill", 180, 450, 10) end
  if states.down.ad then love.graphics.circle("fill", 300, 450, 10) end
  if states.down.da then love.graphics.circle("fill", 450, 450, 10) end
  if states.down.d  then love.graphics.circle("fill", 550, 450, 10) end

  if states.down.awd then love.graphics.circle("fill", 370, 300, 15) end
end
