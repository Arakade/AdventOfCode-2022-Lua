-- Advent of code, day 04
-- Lua for Windows includes an out-of-date LuaUnit so must prepend luaunit path!
pathOrig = pathOrig or package.path -- workaround for live coding
package.path = [[./src/?.lua;]] .. pathOrig
local luaunit = require('luaunit')

local Utils = require('utils')

-- http://math2.org/luasearch/rex.html
require('rex') -- rex_posix

local phase

local function parseInstructions(line, lineNum)
  local numMatches = 0
  local num, from, to = rex.match(line, [[^move (\d) from (\d) to (\d)]])
  io.write(string.format("(%s-%s-%s)", num, from, to))
end

local function parseStacks(line, lineNum)
  local numMatches = 0
  for a, b, c in rex.gmatch(line, [[([\[ ])([0-9A-Z ])([\] ]) ?]]) do
    numMatches = numMatches + 1
    io.write(string.format("(%s%s%s)", a, b, c))
    if '1' == b then
      io.write("Parsing instructions")
      phase = parseInstructions
      return
    end
  end
end

local function part1(line, lineNum)
  if line == '' then
    return
  end
  
  io.write(string.format("%4d: %3s: ", lineNum, line))
  phase(line, lineNum)
  io.write('\n')
end

--
-- MAIN
--
local fNam = "data/05-test.txt"
phase = parseStacks
Utils.readAndProcessLines(fNam, part1, false, true)

--luaunit.LuaUnit.run()

print(' == done == ')
