# Combo
The goal of Combo is to provide way to detect key combinations sometimes referred as hotkeys. Combo was created for LÖVE, but it doesn't depend on it.

Combo doesn't address how the inputs are "sensed". Inputs can be detected using love.keyboard.isDown, but something like [baton](https://github.com/tesselode/baton) created by tesselode is recommended.

This module was rewritten several times during it's creation. The idea of "A+B" has many interpretations. This module may have solved the "key combinations" in a way that you may not find useful. Please see the examples.

# Simple usage
First of all the module must be required and assigned to a variable.

New object can be created by calling the new-function. Lastly the key combinations are expressed in a table.

```lua
combo = require "combo"

combo.sequence = {"subweapon", {"up", "x"} }
```

Alternate way.

```lua
combo = require "combo"

hotkey = combo.new({"subweapon", {"up", "x"} })
```

Key combinations can also be detected from unpressed keys. In addition to "down" states additional table for "up" states can be created to provide a reference which keys cannot be pressed when executing the key combination.

```lua
combo = require "combo"

--Subweapon cannot be pressed while player is also pressing right.
hotkey = combo.new({"subweapon", {"up", "x"}, {"right"} })
```

Lastly where the hotkey detection is needed it can be done by reading the object's, "down", "pressed" and "released" table fields.

```lua
if hotkey.pressed.subweapon then
  print("Throwing an axe!")
end
```

# Key combination table syntax
First of all, before using the advanced features, the object needs to be provided isPressed-function.
It is also recommended that the isDown-function is also replaced for consistency. By default isPressed is love.keyboard.isDown. The advanced examples are done using [baton](https://github.com/tesselode/baton).

```lua
--input is an object created using baton
hotkey.isDown = function(key)
  return input:down(key)
end

hotkey.isPressed = function(key)
  return input:pressed(key)
end
```

With the isPressed-function we can differentiate the key combinations with a 3rd table that has all the "pressed" states.

```lua
hotkey.sequence = {
  --name, down, up, pressed
  {"subweapon", {"up", "attack"}, {}, {"attack"} }
}
```

Only the first four fields are used.
* First field is **name** and it is used as the key to store and read the down/pressed/released states.
* Second field is the **positive key modifiers**. These must be pressed down.
* Third field is the **negative key modifiers**. These must not be pressed down.
* Fourth field is the **"pressed"** keys. In the examples the "pressed" keys are true only for a single frame.

The tables need to contain strings that can be used with isDown and isPressed-functions. In the case of love.keyboard.isDown official LÖVE [key constants](https://love2d.org/wiki/KeyConstant) are used. With [baton](https://github.com/tesselode/baton) the names of the inputs are the way you name them.

Detection of key combinations can differ depending on the implementation of isDown and isPressed-functions. For example a time-based isPressed-function can be more useful than frame-based when key comnination requires careful simultanious key presses.

# Advanced usage
The more overlapping the key combinations become the more important the isPressed-function becomes. Simple usage is enough if A+B is considered the same as B+A. If the order matters it can be differentiated with the isPressed-function.

```lua
hotkey.sequence = {
  --name, down, up, pressed
  {"subweapon",   {"up", "attack"}, {}, {"attack"} },
  {"jump_attack", {"up", "attack"}, {}, {"up"} }
}
```

If hotkey can be executed in several ways, all the ways can be written in the table. If any of these key combinations is true, then the hotkey is true regardless how many of the others are false.

```lua
hotkey.sequence = {
  --name, down, up, pressed
  {"subweapon",   {"up", "attack"}, {}, {"attack"} },
  {"subweapon", {"special1"} }
}
```

# Simple source code example
combo = require "combo"

love.load = function()

  hotkey = combo.new {
     {"subweapon", {"up", "x"} }
  }
end

love.update = function()
  hotkey:update()

  if combo.pressed.subweapon then
    print("Throwing an axe!")
  end
end

love.draw = function()

end

love.keypressed = function(key)
  print(key)
end
