-- Advent of code, day 06
-- Lua for Windows includes an out-of-date LuaUnit so must prepend luaunit path!
pathOrig = pathOrig or package.path -- workaround for live coding
package.path = [[./src/?.lua;]] .. pathOrig

local Utils = require('utils')

local AOC6 = require('aoc-day-06-lib')

--
-- MAIN
--
local fNam = "data/06-input.txt"
AOC6.setPatternLength(14)
Utils.readAndProcessLines(fNam, AOC6.process, false, true)

print(' == done == ')
