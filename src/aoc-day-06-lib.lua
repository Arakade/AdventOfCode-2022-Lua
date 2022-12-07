-- Advent of code, day 04
-- Lua for Windows includes an out-of-date LuaUnit so must prepend luaunit path!
pathOrig = pathOrig or package.path -- workaround for live coding
package.path = [[./src/?.lua;]] .. pathOrig
local luaunit = require('luaunit')

local Utils = require('utils')
local Log = require('Log')

-- http://math2.org/luasearch/rex.html
require('rex') -- rex_posix

Log.doLog = false
local AOC = {}

AOC.patternLength = 4

local function checkFrom(i, line)
  local c = {}
  for j = 0,AOC.patternLength-1 do
    local k = i - j
--    c[4 - j] = line:sub(k, k)
    local letter = line:sub(k, k)
    Log:log("%s,", letter)
    if c[letter] then
      Log:log(" = nope\n")
      return false
    end
    c[letter] = true
  end  
  Log:log("Found:")
  for k,_ in pairs(c) do
    Log:log(k)
  end
  
  return true
end

function AOC.setPatternLength(newLength)
  print("Updating patternLength from " .. AOC.patternLength .. " to " .. newLength)
  AOC.patternLength = newLength
end

function AOC.process(line, lineNum)
  Log:log("processing " .. line)
  --local regex = [[(?<!q)m]]
  --local match = rex.find(line, regex, 3)
  -- phase 1 populate buffer with inital 3 chars
  -- iterate forwards shuffling letters backwards
  for i = AOC.patternLength, #line do
    Log:log("  %d:", i)
    if checkFrom(i, line) then
      print(" = " .. i)  -- deliberately use print to show answer
      return i
    end
  end
  --error("Failed to find anything")
end

local testData = {
  { input = "mjqjpqmgbljsphdztnvjfqwrcgsmlb", expected = { 7, 19 } },
  { input = "bvwbjplbgvbhsrlpgdmjqwftvncz", expected = { 5, 23 } },
  { input = "nppdvjthqldpwncqszvftbrmjlhg", expected = { 6, 23 } },
  { input = "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", expected = { 10, 29 } },
  { input = "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", expected = { 11, 26 } },
}

local function doTest(input, patternLength, expected)
  Log:log("patternLength:%d:\n", patternLength)
  AOC.setPatternLength(patternLength)
  local actual = AOC.process(input, 1)
  luaunit.assertEquals(actual, expected)
end

function testAll()
  for i,v in ipairs(testData) do
    Log:log("\nTest %d: ", i)
    doTest(v.input, 4, v.expected[1])
    Log:log("\nTest %d: ", i)
    doTest(v.input, 14, v.expected[2])
    Log:log("\n")
  end
end

--luaunit.LuaUnit.run()

return AOC