# Combo
Combo is a key combination detection module for LÖVE.

The goal of Combo is to provide logic for testing hotkeys or key combinations.

Combo doesn't address how the inputs are "sensed".

Inputs can be detected using love.keyboard.isDown, but something like (baton)[https://github.com/tesselode/baton] created by tesselode is recommended.

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

# Key combination table syntax


# Advanced usage


# Advanced source code example
