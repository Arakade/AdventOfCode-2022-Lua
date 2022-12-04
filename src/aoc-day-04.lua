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
  local a = {}
  local b = {}
  a[1], a[2], b[1], b[2] = rex.match(line, [[^(\d+)-(\d+),(\d+)-(\d+)$]])
  io.write(string.format("(%d-%d) (%d-%d) ", a[1], a[2], b[1], b[2]))
  
  -- Don't forget to convert from strings to numbers -- Lua will 'help' and give the wrong answer! eh-hum
  a[1] = tonumber(a[1])
  a[2] = tonumber(a[2])
  b[1] = tonumber(b[1])
  b[2] = tonumber(b[2])
  
  -- swap if inverted
  if a[2] < a[1] then
    a[1], a[2] = a[2], a[1]
  end
  if b[2] < b[1] then
    b[1], b[2] = b[2], b[1]
  end
  
  -- check containment
  if ( a[1] >= b[1] and a[2] <= b[2] ) or ( b[1] >= a[1] and b[2] <= a[2] ) then
    total = total + 1
    
    io.write(" = FULLY CONTAINED")
  end
  io.write('\n')
end

local function part2(line, lineNum)
  if line == '' then
    return
  end
  
  io.write(string.format("%4d: %3s: ", lineNum, line))
  local a = {}
  local b = {}
  a[1], a[2], b[1], b[2] = rex.match(line, [[^(\d+)-(\d+),(\d+)-(\d+)$]])
  io.write(string.format("(%d-%d) (%d-%d) ", a[1], a[2], b[1], b[2]))
  
  -- Don't forget to convert from strings to numbers -- Lua will 'help' and give the wrong answer! eh-hum
  a[1] = tonumber(a[1])
  a[2] = tonumber(a[2])
  b[1] = tonumber(b[1])
  b[2] = tonumber(b[2])
  
  -- swap if inverted
  if a[2] < a[1] then
    a[1], a[2] = a[2], a[1]
  end
  if b[2] < b[1] then
    b[1], b[2] = b[2], b[1]
  end
  
  -- make 'a' be the lower-starting of the 2 ranges
  if a[1] > b[1] then
    a, b = b, a
  end
  
  -- check containment
  if (a[2] > b[2] and a[1] <= b[2]) or (a[2] >= b[1] and a[2] <= b[2]) then
    total = total + 1
    
    io.write(" = PARTIALLY CONTAINED")
  end
  io.write('\n')
end

--
-- MAIN
--
local fNam = "data/04-input.txt"
Utils.readAndProcessLines(fNam, part2, false, true)
print('total:' .. total)

--luaunit.LuaUnit.run()

print(' == done == ')
