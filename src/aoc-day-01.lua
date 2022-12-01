-- Advent of code, day 01

-- http://math2.org/luasearch/rex.html
local re = require('rex')
if nil == re then
  error('No Regex')
end

local totals = {}

local sum = 0

local function doLine(line, lineNum)
  io.write(string.format("%4d : %10s : ", lineNum, line))
  local numMatches = 0
  for match in rex.gmatch(line, "^[0-9]+$") do
    numMatches = numMatches + 1
    io.write(match)
    sum = sum + tonumber(match)
  end
  io.write(string.format(" : %5d\n", sum))
  if 0 == numMatches then
    totals[#totals + 1] = sum
    sum = 0
  end
end


--
-- MAIN
--
local fNam = "data/01-01-input.txt"
local f = io.open(fNam, "r")
local lineNum = 1
while true do
  local line = f:read("*line")
  if line == nil then break end
    doLine(line, lineNum)
  lineNum = lineNum + 1
end
doLine("", lineNum) -- one extra to process the final line = kludge

table.sort(totals)

local sum = totals[#totals] + totals[#totals - 1] + totals[#totals - 2]

print("sum:", sum)

print('done')