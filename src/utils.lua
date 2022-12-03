
local Utils = {}

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

function Utils.readAndProcessLines(fNam, lineFunc, extraLineAtEnd, skipBlanks)
  extraLineAtEnd = extraLineAtEnd or true
  skipBlanks = skipBlanks or false

  local f = io.open(fNam, "r")
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

--- Returns a new array table with members that are the keys present in both tables
function Utils.unionKeys(a, b)
  local union = {}
  for ka in pairs(a) do
    if b[ka] ~= nil then
      union[#union + 1] = ka
    end
  end
  return union
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