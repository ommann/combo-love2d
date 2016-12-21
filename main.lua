combo = require "combo"

love.load = function()

  hotkey = combo.new {
     {"subweapon", {"up", "x"} }
  }
end

love.update = function()
  hotkey:update()

  if hotkey.pressed.subweapon then
    print("Throwing an axe!")
  end
end

love.draw = function()

end

love.keypressed = function(key)
  print(key)
end
