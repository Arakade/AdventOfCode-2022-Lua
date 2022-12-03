-- Lua for Windows includes an out-of-date LuaUnit so must prepend luaunit path!
pathOrig = pathOrig or package.path -- workaround for live coding
package.path = [[./src/?.lua;]] .. pathOrig
local luaunit = require('luaunit')

local Utils = require('utils')

function testTableHasValue()
  local t = { 5, 6, 7, 8 }
  luaunit.assertTrue(Utils.tableHasValue(t, 5))
  luaunit.assertFalse(Utils.tableHasValue(t, 10))
end

function testUnionKeys()
  local a = { a = 1, b = 1, c = 1 }
  local b = { b = 1, c = 1, d = 1 }
  local actual = Utils.unionKeys(a, b)
  luaunit.assertEquals(#actual, 2)
  luaunit.assertEquals(actual[1], 'b')
  luaunit.assertEquals(actual[2], 'c')
end

luaunit.LuaUnit.run()
