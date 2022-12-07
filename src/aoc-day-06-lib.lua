-- Advent of code, day 04
-- Lua for Windows includes an out-of-date LuaUnit so must prepend luaunit path!
pathOrig = pathOrig or package.path -- workaround for live coding
package.path = [[./src/?.lua;]] .. pathOrig
local luaunit = require('luaunit')

local Utils = require('utils')

-- http://math2.org/luasearch/rex.html
require('rex') -- rex_posix

local AOC = {}

AOC.patternLength = 4

local function checkFrom(i, line)
  local c = {}
  for j = 0,AOC.patternLength-1 do
    local k = i - j
--    c[4 - j] = line:sub(k, k)
    local letter = line:sub(k, k)
    Utils.log("%s,", letter)
    if c[letter] then
      Utils.log(" = nope\n")
      return false
    end
    c[letter] = true
  end  
  --Utils.log("[%s,%s,%s,%s]\n", c[1], c[2], c[3], c[4])
  Utils.showTable(c, true)
  return true
end


function AOC.part1(line, lineNum)
  --local regex = [[(?<!q)m]]
  --local match = rex.find(line, regex, 3)
  -- phase 1 populate buffer with inital 3 chars
  -- iterate forwards shuffling letters backwards
  for i = AOC.patternLength, #line do
    Utils.log("  %d:", i)
    if checkFrom(i, line) then
      Utils.log(" found %d", i) 
      return i
    end
  end
end

local testData = {
  { input = "mjqjpqmgbljsphdztnvjfqwrcgsmlb", expected = { 7, 19 } },
  { input = "bvwbjplbgvbhsrlpgdmjqwftvncz", expected = { 5, 23 } },
  { input = "nppdvjthqldpwncqszvftbrmjlhg", expected = { 6, 23 } },
  { input = "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", expected = { 10, 29 } },
  { input = "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", expected = { 11, 26 } },
}

local function doTest(input, patternLength, expected)
  Utils.log("patternLength:%d:\n", patternLength)
  AOC.patternLength = patternLength
  local actual = AOC.part1(input, 1)
  luaunit.assertEquals(actual, expected)
end

function testAll()
  for i,v in ipairs(testData) do
    log("\nTest %d: ", i)
    doTest(v.input, 4, v.expected[1])
    log("\nTest %d: ", i)
    doTest(v.input, 7, v.expected[2])
    log("\n")
  end
end

luaunit.LuaUnit.run()

return AOC