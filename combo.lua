local M = {}

--[[
if love.keyboard.isDown then
  M.isDown = love.keyboard.isDown
end

M.down = {}
M.previous_down = {}
M.pressed = {}
M.released = {}
--]]


M.test_sequences = function(self)
  local override = {}

  for _,sequence in ipairs(self.sequences) do
    local name     = sequence[1]
    local positive = sequence[2]
    local negative = sequence[3]
    local pressed  = sequence[4]

    local bool = true
    local bool_down = nil

    if positive then
      for _,input in ipairs(positive) do
        bool = bool and self.isDown(input)
      end
    end

    if negative then
      for _,input in ipairs(negative) do
        bool = bool and not self.isDown(input)
      end
    end

    bool_down = bool

    if pressed then
      for _,input in ipairs(pressed) do
        bool = bool and self.isPressed(input)
      end
    end

    if bool == true then
      self.down[name] = true
      override[name] = true
    end

    if bool == false and not pressed then
      self.down[name] = false
    end

    if bool == false and pressed and not bool_down then
      self.down[name] = false
    end
  end

  for i,v in pairs(override) do
    self.down[i] = v
  end
end

M.update = function(self)
  self.pressed = {}
  self.released = {}

  for i,v in pairs(self.down) do
    self.previous_down[i] = v
  end

  self:test_sequences()

  for input,_ in pairs(self.down) do
    self.pressed[input] = self.down[input] and not self.previous_down[input]
  end

  for input,_ in pairs(self.previous_down) do
    self.released[input] = self.previous_down[input] and not self.down[input]
  end
end

M.new = function(sequences)
  local output = {}

  output.sequences = sequences

  output.down = {}
  output.previous_down = {}
  output.pressed = {}
  output.released = {}

  if love.keyboard.isDown then
    output.isDown = love.keyboard.isDown
  end

  output.test_sequences = M.test_sequences
  output.update = M.update

  return output
end

return M
