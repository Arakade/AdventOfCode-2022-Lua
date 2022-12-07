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
Utils.readAndProcessLines(fNam, AOC6.part1, false, true)

print(' == done == ')
