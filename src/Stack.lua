-- A simple Stack class

local Stack = {}

function Stack.new(o)
  local stack = {}
  stack.members = o or {}
  setmetatable(stack, Stack)
  -- stack.__index = Stack
  return stack
end

--
-- MEMBER FUNCTIONS
--

--- Also allows retrieving by index within the Stack.  Only really useful when single member!
function Stack:__index(table, key, ...)
  -- print("__index, self:", self, "table:", table, type(table), "key:", key, "...", ...)
  if 'number' == type(table) then
    return self.members[table]
  end
  if nil ~= Stack[table] then
    return Stack[table]
  end
end

function Stack:__tostring()
  local s = '{'
  local count = 0
  for _,v in pairs(self.members) do
    if 0 ~= count then
      s = s .. ', '
    end
    s = s .. v
    count = count + 1
  end
  s = s .. '}'
  return s
end

function Stack:push(v)
  self.members[#self.members + 1] = v
end

function Stack:pop()
  local v = self.members[#self.members]
  self.members[#self.members] = nil
  return v
end

function Stack:peek()
  return self.members[#self.members]
end

function Stack:__eq(other)
  return Stack.areEqual(self, other)
end

function Stack:__ipairs()
  local i = 1
  return function ()
    if i <= #self.members then
      local v = self.members[i]
      i = i + 1
      return v
    end
  end
end

-- Add values from an iterator
function Stack:addFromIterator(iterator)
  for v in iterator do
    self:push(v)
  end
end

function Stack:__len()
  return #self.members
end

function Stack:invert()
  local len = #self.members
  local len_2 = len / 2
  for i = 0,len_2 - 1 do
    -- swap
    self.members[i + 1], self.members[len - i] = self.members[len - i], self.members[i + 1]
  end
end

--
-- STATIC FUNCTIONS
--

function Stack.areEqual(a, b)
  if nil == a.members or nil == b.members then
    return false
  end
  
  if #a.members ~= #b.members then
    return false
  end
  for i, v in ipairs(a.members) do
    if b.members[i] ~= v then
      return false
    end
  end
  return true
end

return Stack