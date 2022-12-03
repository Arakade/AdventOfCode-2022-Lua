-- Lua for Windows includes an out-of-date LuaUnit so must prepend luaunit path!
pathOrig = pathOrig or package.path -- workaround for live coding
package.path = [[./src/?.lua;]] .. pathOrig
local luaunit = require('luaunit')
local Set = require('Set')

function testToStringEmpty()
  local s = Set.new()
  local actual = tostring(s)
  luaunit.assertEquals(actual, "{}")
end

function testToStringOneItem()
  local s = Set.new({'a'})
  local actual = tostring(s)
  luaunit.assertEquals(actual, "{a}")
end

function testToStringThreeItems()
  local s = Set.new({'a', 'b', 5})
  local actual = tostring(s)
  luaunit.assertTrue(nil ~= actual:match('a'), actual)
  luaunit.assertTrue(nil ~= actual:match('b'), actual)
  luaunit.assertTrue(nil ~= actual:match('5'), actual)
end

function testContains()
  local s = Set.new({'a'})
  luaunit.assertTrue(s:contains('a'), actual)
  luaunit.assertFalse(s:contains('b'), actual)
end

function testEqTrue()
  local a = Set.new({1, 2, 3, 4})
  local b = Set.new({1, 2, 3, 4})
  luaunit.assertEquals(a, b)
end

function testEqFalse()
  local a = Set.new({1, 2, 3, 4})
  local b = Set.new({42, 2, 3, 4})
  luaunit.assertNotEquals(a, b)
end

function testUnion()
  local a = Set.new({1, 2, 3, 4})
  local b = Set.new({3, 4, 5, 6})
  luaunit.assertEquals(Set.union(a, b), Set.new({1, 2, 3, 4, 5, 6}))
end

function testIntersection()
  local a = Set.new({1, 2, 3, 4})
  local b = Set.new({3, 4, 5, 6})
  luaunit.assertEquals(Set.intersection(a, b), Set.new({3, 4}))
end

function testLen()
  local a = Set.new({1, 2, 3, 4})
  luaunit.assertEquals(#a, 4)
end

luaunit.LuaUnit.run()
