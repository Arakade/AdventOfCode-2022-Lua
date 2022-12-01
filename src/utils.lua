
local Utils = {}

function Utils.showTable(t)
  for k,v in ipairs(t) do
    io.write(k, " : ", v, "\n")
  end
end

function Utils.readAndProcessLines(fNam, lineFunc)
  local f = io.open(fNam, "r")
  local lineNum = 1
  while true do
    local line = f:read("*line")
    if line == nil then break end
    lineFunc(line, lineNum)
    lineNum = lineNum + 1
  end
  lineFunc("", lineNum) -- one extra to process the final line = kludge
end

return Utils