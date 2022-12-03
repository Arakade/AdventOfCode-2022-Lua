-- Advent of code, day 03
-- Lua for Windows includes an out-of-date LuaUnit so must prepend luaunit path!
pathOrig = pathOrig or package.path -- workaround for live coding
package.path = [[./src/?.lua;]] .. pathOrig
local luaunit = require('luaunit')

local Utils = require('utils')

-- http://math2.org/luasearch/rex.html
require('rex') -- rex_posix

local function charToNumber(c)
  local a = 1 + string.byte(c) - string.byte('a')
  if 0 > a then
    a = 1 + 26 + string.byte(c) - string.byte('A')
  end
  return a
end

local total = 0

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
  
  for c in p2:gmatch('.') do
    if counts[c] ~= nil then
      local a = charToNumber(c)
      io.write(string.format(' = %s = %d\n', c, a))
      total = total + a
      return c, a
    end
  end
  -- Utils.showTable(counts)
  io.write(' = NO DUPS\n')
end


--
-- MAIN
--
local fNam = "data/03-input.txt"
Utils.readAndProcessLines(fNam, part1, false, true)
print('total:' .. total)

--luaunit.LuaUnit.run()

print(' == done == ')