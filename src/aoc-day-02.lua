-- Advent of code, day 01
package.path = package.path .. [[;./src/?.lua]]
local Utils = require('utils')

-- http://math2.org/luasearch/rex.html
-- local re = 
require('rex') -- rex_posix
--if nil == re then
--  error('No Regex')
--end

-- print(rex.version())
--Utils.showTable(rex.flags())
--local RE_Extended = rex.flags()["EXTENDED"]

-- Them | Us : Choice   : Score
-- A    | X  : Rock     : 1
-- B    | Y  : Paper    : 2
-- C    | Z  : Scissors : 3

local ChoiceToScore = {
  X = 1,
  Y = 2,
  Z = 3,
}

local ResultLoss = -1
local ResultDraw =  0
local ResultWin  =  1

local ResultToScore = {}
ResultToScore[ResultLoss] = 0
ResultToScore[ResultDraw] = 3
ResultToScore[ResultWin ] = 6

-- How to compare ABC with XYZ to give win/loss/draw
local Compare = {
  X = { -- rock
    A = ResultDraw, -- rock
    B = ResultLoss, -- paper
    C = ResultWin,  -- scissors
  },
  Y = { -- paper
    A = ResultWin,  -- rock
    B = ResultDraw, -- paper
    C = ResultLoss, -- scissors
  },
  Z = { -- scissors
    A = ResultLoss, -- rock
    B = ResultWin,  -- paper
    C = ResultDraw, -- scissors
  },
}

local total = 0

local function doLine(line, lineNum)
  if line == '' then
    return
  end
  
  io.write(string.format("%4d : %3s : ", lineNum, line))
  local them, us = rex.match(line, "^([A-C]).([X-Z])$")
  io.write(string.format("%s vs %s", them, us))
  local result = Compare[us][them]
  io.write(string.format(" result: %2d", result))
  local score = ChoiceToScore[us] + ResultToScore[result]
  io.write(string.format(" score: %d", score))
  io.write("\n")
  total = total +  score
end

--
-- MAIN
--
local fNam = "data/02-test.txt"
Utils.readAndProcessLines(fNam, doLine, false, true)

print('total:' .. total)

print(' == done == ')