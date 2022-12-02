-- Advent of code, day 02
package.path = package.path .. [[;./src/?.lua]]
local Utils = require('utils')

-- http://math2.org/luasearch/rex.html
require('rex') -- rex_posix

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

-- Compare ABC with XYZ to give win/loss/draw
local Part1GetResult = {
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

local Part2GetResponse = {
  A = {
    X = 'Z', -- lose
    Y = 'X', -- draw
    Z = 'Y', -- win
  },
  B = {
    X = 'X', -- lose
    Y = 'Y', -- draw
    Z = 'Z', -- win
  },
  C = {
    X = 'Y', -- lose
    Y = 'Z', -- draw
    Z = 'X', -- win
  },
}

local Part2ResultToScore = {
  X = ResultLoss,
  Y = ResultDraw,
  Z = ResultWin,
}

local total = 0

local function part1(line, lineNum)
  if line == '' then
    return
  end
  
  io.write(string.format("%4d : %3s : ", lineNum, line))
  local them, us = rex.match(line, "^([A-C]).([X-Z])$")
  io.write(string.format("%s vs %s", them, us))
  local result = Part1GetResult[us][them]
  io.write(string.format(" result: %2d", result))
  local score = ChoiceToScore[us] + ResultToScore[result]
  io.write(string.format(" score: %d", score))
  io.write("\n")
  total = total +  score
end

local function part2(line, lineNum)
  if line == '' then
    return
  end
  
  io.write(string.format("%4d : %3s : ", lineNum, line))
  local them, result = rex.match(line, "^([A-C]).([X-Z])$")
  io.write(string.format("(them:%s, result:%s) ", them, result))
  local us = Part2GetResponse[them][result]
  io.write(string.format("us:%2s ", us))
  local choiceScore = ChoiceToScore[us]
  local resultScore = ResultToScore[Part2ResultToScore[result]]
  io.write(string.format("(%s + %s) ", tostring(choiceScore), tostring(resultScore)))
  local score = choiceScore + resultScore
  io.write(string.format(" score: %d", score))
  io.write("\n")
  total = total +  score
end

--
-- MAIN
--
local fNam = "data/02-input.txt"
Utils.readAndProcessLines(fNam, part2, false, true)

print('total:' .. total)

print(' == done == ')