-- Advent of code, day 04
-- Lua for Windows includes an out-of-date LuaUnit so must prepend luaunit path!
pathOrig = pathOrig or package.path -- workaround for live coding
package.path = [[./src/?.lua;]] .. pathOrig
--local luaunit = require('luaunit')

local Utils = require('utils')
local Stack = require('Stack')

-- http://math2.org/luasearch/rex.html
require('rex') -- rex_posix

---An array of stacks
local stacks = {}

---The phase currently in = a function.
local phase

local function log(fmtMsg, ...)
  io.write(string.format(fmtMsg, ...))
end

local function dumpStacks()
  for i,v in ipairs(stacks) do
    log("%3d: %s\n", i, v)
  end
end

local function parseInstructions(line, lineNum)
  local numMatches = 0
  local num, from, to = rex.match(line, [[^move (\d) from (\d) to (\d)]])
  log("(%s-%s-%s)", num, from, to)
  assert(nil ~= num)
  assert(nil ~= from)
  assert(nil ~= to)
  num, from, to = tonumber(num), tonumber(from), tonumber(to)
  for i = 1, num do
    stacks[to]:push(stacks[from]:pop())
--    local v = stacks[from]:pop()
--    log("moving %s from %d:%s to %d:%s\n", v, from, stacks[from], to, stacks[to])
--    stacks[to]:push(v)
  end
end

local function invertAllStacks()
  log(" (after inverting all stacks)")
--  log("\nbefore:\n")
--  dumpStacks()
  for _,v in pairs(stacks) do
    v:invert()
  end
--  log("\nafter:\n")
--  dumpStacks()
end

local function parseStacks(line, lineNum)
  io.write("-> ")
  local stackNum = 1
  for a, b, c in rex.gmatch(line, [[([\[ ])([0-9A-Z ])([\] ]) ?]]) do
    log("%d(%s%s%s) ", stackNum, a, b, c)
    if '1' == b then
      log(" => Parsing instructions")
      phase = parseInstructions
      invertAllStacks()
      return
    end
    -- Still reading stacks
    if ' ' ~= b then
      if nil == stacks[stackNum] then
        --log(" (creating stack %d with %s) ", stackNum, b)
        stacks[stackNum] = Stack.new({b})
      else
        --log(" (adding %s to stack %d %s) ", b, stackNum, tostring(stack))
        stacks[stackNum]:push(b) -- TODO: wrong way round => perhaps empty every stack into another to fix ordering?
      end
    end
    stackNum = stackNum + 1
  end
end

local function part1(line, lineNum)
  if line == '' then
    return
  end
  
  log("%4d: %3s: ", lineNum, line)
  phase(line, lineNum)
  log('\n')
end

local function concatStackTopsAsString()
  local s = ''
  for _,v in ipairs(stacks) do
    s = s .. v:peek()
  end
  return s
end

--
-- MAIN
--
local fNam = "data/05-test.txt"
phase = parseStacks
Utils.readAndProcessLines(fNam, part1, false, true)

log("Results:\n")
dumpStacks()

print("Message: " .. concatStackTopsAsString())

--luaunit.LuaUnit.run()

print(' == done == ')
