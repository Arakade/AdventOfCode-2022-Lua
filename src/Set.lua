-- A simple Set class

local Set = {}

function Set.new(o)
  local set = {}
  if nil ~= o then
    for k,v in pairs(o) do
      set[v] = 1
    end
  end
  setmetatable(set, Set)
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
  for k,v in pairs(self) do
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
  return nil ~= self[v]
end

function Set:add(v)
  self[v] = 1
end

function Set:remove(v)
  self[v] = nil
end

function Set:equals(other)
  return Set.equal(self, other)
end

--
-- STATIC FUNCTIONS
--

--- Returns a new Set with members that are the keys present in either table.
function Set.union(a, b)
  local union = Set.new()
  for k in pairs(a) do
    union[k] = 1
  end
  for k in pairs(b) do
    union[k] = 1
  end
  return union
end

--- Returns a new Set with members that are the present in both.
function Set.intersection(a, b)
  local intersection = Set.new()
  for k in pairs(a) do
    if nil ~= b[k] then
      intersection[k] = 1
    end
  end
  return intersection
end

function Set.__eq(a, b)
  if #a ~= #b then
    return false
  end
  for k in pairs(a) do
    if nil == b[k] then
      return false
    end
  end
  return true
end

return Set