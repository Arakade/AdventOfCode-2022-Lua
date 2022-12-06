-- Lua for Windows includes an out-of-date LuaUnit so must prepend luaunit path!
pathOrig = pathOrig or package.path -- workaround for live coding
package.path = [[./src/?.lua;]] .. pathOrig
local luaunit = require('luaunit')
local Stack = require('Stack')

function testToStringEmpty()
  local s = Stack.new()
  local actual = tostring(s)
  luaunit.assertEquals(actual, "{}")
end

function testToStringOneItem()
  local s = Stack.new({'a'})
  local actual = tostring(s)
  luaunit.assertEquals(actual, "{a}")
end

function testToStringThreeItems()
  local s = Stack.new({'a', 'b', 5})
  local actual = tostring(s)
  luaunit.assertEquals(actual, "{a, b, 5}")
end

function testEqTrue()
  local a = Stack.new({1, 2, 3, 4})
  local b = Stack.new({1, 2, 3, 4})
  luaunit.assertEquals(a, b)
end

function testEqFalse()
  local a = Stack.new({1, 2, 3, 4})
  local b = Stack.new({42, 2, 3, 4})
  luaunit.assertNotEquals(a, b)
end

function testLen()
  local a = Stack.new({1, 2, 3, 4})
  luaunit.assertEquals(#a, 4)
end

function testPush()
  local a = Stack.new()
  a:push(1)
  a:push(2)
  local actual = tostring(a)
  luaunit.assertEquals(actual, "{1, 2}")
end

function testPop()
  local a = Stack.new({1, 2, 3, 4})
  local popped = a:pop()
  luaunit.assertEquals(popped, 4)
  popped = a:pop()
  luaunit.assertEquals(popped, 3)
  local actual = tostring(a)
  luaunit.assertEquals(actual, "{1, 2}")
end

function testAddFromIterator()
  local s = Stack.new()
  local i = 0
  local iterator = function() if i < 5 then i = i + 1 return i end end
  s:addFromIterator(iterator)
  luaunit.assertEquals(s, Stack.new({1, 2, 3, 4, 5}))
end

function testIndex()
  local a = Stack.new({'hello'})
  luaunit.assertEquals(a[1], 'hello')
end

function testPairs()
  local expected = {5, 6, 7, 8}
  local s = Stack.new({5, 6, 7, 8})
  for i,v in ipairs(s) do
    luaunit.assertEquals(v, expected[i])
  end
end

function testInvertEven()
  local s = Stack.new({5, 6, 7, 8})
  s:invert()
  luaunit.assertEquals(s, Stack.new({8, 7, 6, 5}))
end

function testInvertOdd()
  local s = Stack.new({4, 5, 6, 7, 8})
  s:invert()
  luaunit.assertEquals(s, Stack.new({8, 7, 6, 5, 4}))
end

function testPeekSome()
  local s = Stack.new({4, 5, 6, 7, 8})
  luaunit.assertEquals(s:peek(), 8)
end

function testPeekNone()
  local s = Stack.new({})
  luaunit.assertEquals(s:peek(), nil)
end

luaunit.LuaUnit.run()
