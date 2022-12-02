
local Utils = {}

function Utils.showTable(t)
  for k,v in ipairs(t) do
    io.write(k, " : ", v, "\n")
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

return Utils