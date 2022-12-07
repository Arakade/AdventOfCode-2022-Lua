-- Advent of code, day 04
-- Lua for Windows includes an out-of-date LuaUnit so must prepend luaunit path!
pathOrig = pathOrig or package.path -- workaround for live coding
package.path = [[./src/?.lua;]] .. pathOrig
local luaunit = require('luaunit')

local Utils = require('utils')

-- http://math2.org/luasearch/rex.html
require('rex') -- rex_posix

local AOC6 = {}

local function checkFrom(i, line)
  local c = {}
  for j = 0,3 do
    local k = i - j
--    c[4 - j] = line:sub(k, k)
    local letter = line:sub(k, k)
    if c[letter] then
      return false
    end
    c[letter] = true
  end  
  --Utils.log("[%s,%s,%s,%s]\n", c[1], c[2], c[3], c[4])
  --Utils.showTable(c, true)
  return true
end

function AOC6.part1(line, lineNum)
  --local regex = [[(?<!q)m]]
  --local match = rex.find(line, regex, 3)
  -- phase 1 populate buffer with inital 3 chars
  -- iterate forwards shuffling letters backwards
  for i = 4, #line do
    Utils.log("[%d]", i)
    if checkFrom(i, line) then
      Utils.log(" found %d", i) 
      return i
    end
  end
end

local testData = {
  { input = "mjqjpqmgbljsphdztnvjfqwrcgsmlb", expected = 7 },
  { input = "bvwbjplbgvbhsrlpgdmjqwftvncz", expected = 5 },
  { input = "nppdvjthqldpwncqszvftbrmjlhg", expected = 6 },
  { input = "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", expected = 10 },
  { input = "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", expected = 11 },
}

local function doTest(input, expected)
  local actual = part1(input, 1)
  luaunit.assertEquals(actual, expected)
end

function testAll()
  for i,v in ipairs(testData) do
    log("\nTest %d: ", i)
    doTest(v.input, v.expected)
    log("\n")
  end
end

--luaunit.LuaUnit.run()

return AOC6