-- Lua for Windows includes an out-of-date LuaUnit so must prepend luaunit path!
pathOrig = pathOrig or package.path -- workaround for live coding
package.path = [[./src/?.lua;]] .. pathOrig
local luaunit = require('luaunit')

local Utils = require('utils')

local TestExpectations = {
  { input = 'vJrwpWtwJgWrhcsFMMfFFhFp', expected = 'p', priority = 16 }, 
  { input = 'jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL', expected = 'L', priority = 38 }, 
  { input = 'PmmdzqPrVvPwwTWBwg', expected = 'P', priority = 42 }, 
  { input = 'wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn', expected = 'v', priority = 22 }, 
  { input = 'ttgJtRGJQctTZtZT', expected = 't', priority = 20 }, 
  { input = 'CrZsJsPPZsGzwwsLwLmpwMDw', expected = 's', priority = 19 }, 
}

function testPart1()
  for i, t in ipairs(TestExpectations) do
    -- Utils.showTable(t)
    local actualItem, priority = part1(t.input, i)
    luaunit.assertEquals(actualItem, t.expected)
    luaunit.assertEquals(priority, t.priority)
  end
end