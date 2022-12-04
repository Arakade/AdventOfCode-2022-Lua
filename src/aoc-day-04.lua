-- Advent of code, day 04
-- Lua for Windows includes an out-of-date LuaUnit so must prepend luaunit path!
pathOrig = pathOrig or package.path -- workaround for live coding
package.path = [[./src/?.lua;]] .. pathOrig
local luaunit = require('luaunit')

local Utils = require('utils')

-- http://math2.org/luasearch/rex.html
require('rex') -- rex_posix

local total = 0

local function part1(line, lineNum)
  if line == '' then
    return
  end
  
  io.write(string.format("%4d: %3s: ", lineNum, line))
  local a1, a2, b1, b2 = rex.match(line, [[^(\d+)-(\d+),(\d+)-(\d+)$]])
  io.write(string.format("(%d-%d) (%d-%d) ", a1, a2, b1, b2))
  
  -- Don't forget to convert from strings to numbers -- Lua will 'help' and give the wrong answer! eh-hum
  a1 = tonumber(a1)
  a2 = tonumber(a2)
  b1 = tonumber(b1)
  b2 = tonumber(b2)
  
  -- swap if inverted
  if a2 < a1 then
    a1, a2 = a2, a1
  end
  if b2 < b1 then
    b1, b2 = b2, b1
  end
  
  -- check containment
  if ( a1 >= b1 and a2 <= b2 ) or ( b1 >= a1 and b2 <= a2 ) then
    total = total + 1
    
    io.write(" = FULLY CONTAINED")
  end
  io.write('\n')
end

--
-- MAIN
--
local fNam = "data/04-input.txt"
Utils.readAndProcessLines(fNam, part1, false, true)
print('total:' .. total)

--luaunit.LuaUnit.run()

print(' == done == ')