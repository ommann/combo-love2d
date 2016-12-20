# Combo
Combo is a key combination detection module for LÖVE.

The goal of Combo is to provide logic for testing hotkeys or key combinations.

Combo doesn't address how the inputs are "sensed".

Inputs can be detected using love.keyboard.isDown, but something like [baton](https://github.com/tesselode/baton) created by tesselode is recommended.

This module was rewritten several times during it's creation. The idea of "a+b" has many interpretations. This module may have solved the "key combinations" in a way that you may not find useful. Please see the examples.

# Simple usage
First of all the module must be required and assigned to a variable.

```lua
combo = require "combo"
```
The module itself functions as an instanced object of the detection logic. Alternatively object can be created by calling the new-function. Lastly the key combinations are expressed in a table.

```lua
combo = require "combo"

combo.sequence = {"subweapon", {"up", "attack"} }
```

Alternate way.

```lua
combo = require "combo"

hotkey = combo.new({"subweapon", {"up", "attack"} })
```

Key combinations can also be detected from unpressed keys. In addition to "down" states additional table for "up" states can be created to provide a reference which keys cannot be pressed when executing the key combination.

```lua
combo = require "combo"

--Subweapon cannot be pressed while player is also pressing right.
hotkey = combo.new({"subweapon", {"up", "attack"}, {"right"} })
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

Detection of key combinations can differ depending on the implementation of isDown and isPressed-functions. For example a time-based isPressed-function can be more useful than frame-based when key comnination requires careful simultanious key presses.

# Advanced usage


# Advanced source code example
