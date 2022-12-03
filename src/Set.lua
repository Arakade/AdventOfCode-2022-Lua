-- A simple Set class

local Set = {}

function Set.new(o)
  local set = { members = {} }
  if nil ~= o then
    for k,v in pairs(o) do
      set.members[v] = 1
    end
  end
  setmetatable(set, Set)
  -- set.__index = Set
  return set
end

--
-- MEMBER FUNCTIONS
--

function Set:__index(table, key, ...)
  return Set[table]
end

function Set:__tostring()
  local s = '{'
  local count = 0
  for k,v in pairs(self.members) do
    if 0 ~= count then
      s = s .. ', '
    end
    s = s .. k
    count = count + 1
  end
  s = s .. '}'
  return s
end

function Set:contains(v)
  return nil ~= self.members[v]
end

function Set:add(v)
  self.members[v] = 1
end

function Set:remove(v)
  self.members[v] = nil
end

function Set:__eq(other)
  return Set.areEqual(self, other)
end

-- Add values from an iterator
function Set:addFromIterator(iterator)
  for v in iterator do
    self:add(v)
  end
end

function Set:__len()
  return #self.members
end

--
-- STATIC FUNCTIONS
--

--- Returns a new Set with members that are the keys present in either table.
function Set.union(a, b)
  local union = Set.new()
  if nil == a.members then
    a = Set.new(a)
  end
  if nil == b.members then
    b = Set.new(b)
  end
  for k in pairs(a.members) do
    union:add(k)
  end
  for k in pairs(b.members) do
    union:add(k)
  end
  return union
end

--- Returns a new Set with members that are the present in both.
function Set.intersection(a, b)
  local intersection = Set.new()
  if nil == a.members then
    a = Set.new(a)
  end
  if nil == b.members then
    b = Set.new(b)
  end
  for k in pairs(a.members) do
    if b:contains(k) then
      intersection:add(k)
    end
  end
  return intersection
end

function Set.areEqual(a, b)
  if nil == a.members or nil == b.members then
    return false
  end
  
  if #a.members ~= #b.members then
    return false
  end
  for k in pairs(a.members) do
    if not b:contains(k) then
      return false
    end
  end
  return true
end

return Set