
local Utils = {}

-- let's pollute the global namespace!
function log(fmtMsg, ...)
  io.write(string.format(fmtMsg, ...))
end

Utils.log = log

---Print table 1-level deep, all on one line by default.
function Utils.showTable(t, newlineDelimited)
  newlineDelimited = newlineDelimited or false
  io.write('{')
  local count = 0
  for k,v in pairs(t) do
    if newlineDelimited then
      io.write('\n ')
    end
    io.write(string.format(' {%s: "%s" (%s)}', tostring(k), tostring(v), type(v)))
    count = count + 1
  end
  if 0 ~= count and newlineDelimited then
    io.write('\n}\n')
  else 
    io.write(' }')
  end
end

---Print table keys like an array
function Utils.showKeys(t)
  io.write('[')
  local count = 0
  for k,v in pairs(t) do
    if 0 ~= count then
      io.write(', ')
    end
    io.write(string.format('%s', tostring(k)))
    count = count + 1
  end
  io.write(']')
end

function Utils.readAndProcessLines(fNam, lineFunc, extraLineAtEnd, skipBlanks)
  extraLineAtEnd = extraLineAtEnd or true
  skipBlanks = skipBlanks or false

  local f = io.open(fNam, "r")
  if nil == f then
    error(string.format('Failed to open file "%s"', fNam))
  end
  
  local lineNum = 1
  while true do
    local line = f:read("*line")
    if line == nil then break end
    if not skipBlanks or line ~= "" then
      --print("LINE:", lineNum, line)
      lineFunc(line, lineNum)
      lineNum = lineNum + 1
    end
  end
  if extraLineAtEnd then
    lineFunc("", lineNum) -- one extra to process the final line = kludge
  end
end

--- Iterate through iterator, for each value returned, increment the count in the table.
function Utils.addCounts(counts, iterator)
  for c in iterator do
    if counts[c] == nil then
      counts[c] = 1
    else
      counts[c] = counts[c] + 1
    end
    --io.write(string.format("%s(%d)", c, counts[c]))
  end
  return counts
end

--- Iterate through iterator, for each value returned, set the value 1.
function Utils.recordPresence(counts, iterator)
  for c in iterator do
    counts[c] = 1
    --io.write(string.format("%s(%d)", c, counts[c]))
  end
  return counts
end

--- Returns a new array table with members that are the keys present in either table.
function Utils.unionKeys(a, b)
  local keysDone = {}
  local union = {}
  for k in pairs(a) do
    keysDone[k] = 1 -- record presence for simpler skipping
    union[#union + 1] = k
  end
  for k in pairs(b) do
    -- only add those not already added
    if keysDone[k] == nil then
      union[#union + 1] = k
    end
  end
  return union
end

--- Returns a new array table with members that are the keys present in both tables
function Utils.intersectKeys(a, b)
  local intersection = {}
  for k in pairs(a) do
    if b[k] ~= nil then
      intersection[#intersection + 1] = k
    end
  end
  return intersection
end

--- Returns boolean indicating presence.
function Utils.tableHasValue(t, value)
    for _, v in pairs(t) do
        if value == v then
            return true
        end
    end

    return false
end

return Utils