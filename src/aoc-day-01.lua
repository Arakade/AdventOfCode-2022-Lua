-- Advent of code, day 01
package.path = package.path .. [[;./src/?.lua]]
local Utils = require('utils')

-- http://math2.org/luasearch/rex.html
local re = require('rex')
if nil == re then
  error('No Regex')
end

local totals = {}
local max = 0
local sum = 0

local function doLine(line, lineNum)
  io.write(string.format("%4d : %10s : ", lineNum, line))
  local numMatches = 0
  for match in rex.gmatch(line, "^[0-9]+$") do
    numMatches = numMatches + 1
    io.write(match)
    sum = sum + tonumber(match)
  end
  io.write(string.format(" = %5d\n", sum))
  if 0 == numMatches then
    totals[#totals + 1] = sum
    if sum > max then
      max = sum
    end
    sum = 0
  end
end

--
-- MAIN
--
local fNam = "data/01-01-test.txt"
Utils.readAndProcessLines(fNam, doLine)

table.sort(totals)

local finalSum = totals[#totals] + totals[#totals - 1] + totals[#totals - 2]

print("\n     max : " .. max, "\nfinalSum : " .. finalSum, "\n")

print(' == done == ')