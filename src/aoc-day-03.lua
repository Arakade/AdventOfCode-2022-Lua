-- Advent of code, day 03
-- Lua for Windows includes an out-of-date LuaUnit so must prepend luaunit path!
pathOrig = pathOrig or package.path -- workaround for live coding
package.path = [[./src/?.lua;]] .. pathOrig
local luaunit = require('luaunit')

local Utils = require('utils')

-- http://math2.org/luasearch/rex.html
require('rex') -- rex_posix


local function part1(line, lineNum)
  if line == '' then
    return
  end
  
  io.write(string.format("%4d: %3s (%2d) : ", lineNum, line, #line))
  local p1 = string.sub(line, 1, #line / 2)
  local p2 = string.sub(line, 1 + #line / 2)
  io.write(string.format("(%s, %s) ", p1, p2))
  local counts = {}
  Utils.recordPresence(counts, p1:gmatch("."))
    
  -- Utils.showTable(counts)
  io.write('\n')
end

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
    local actualItem = part1(t.input, i)
    luaunit.assertEquals(actualItem, t.expected)
  end
end

--
-- MAIN
--
--local fNam = "data/03-test.txt"
--Utils.readAndProcessLines(fNam, part1, false, true)
--print('total:' .. total)

luaunit.LuaUnit.run()

print(' == done == ')