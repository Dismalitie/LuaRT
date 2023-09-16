local ui = require "ui"
local win = ui.Window("orionAPI", "fixed", 520, 400)
local list = ui.List(win, {}, -1, -1, 522, 401)
local lineNum = 0

function readLineFromFile(filename, lineNumber)
  local file = io.open(filename, "r")
  if not file then
    print("Error opening the file.")
    return nil
  end
  local line
  for i = 1, lineNumber do
    line = file:read()
    if not line then
      break
    end
  end
  file:close()
  return line
end

local input = readLineFromFile("orionWorkspace.txt", 2)
win.title = "orionAPI - "..readLineFromFile("orionWorkspace.txt", 1)

function prependStringToLine(filename, lineNumber, prependString)
  -- Open the file for reading and writing
  local file = io.open(filename, "r+")

  -- Check if the file was opened successfully
  if not file then
    print("Error opening the file.")
    return
  end

  -- Read all lines into a table
  local lines = {}
  for line in file:lines() do
    table.insert(lines, line)
  end

  -- Modify the desired line by prepending the string
  if lineNumber >= 1 and lineNumber <= #lines then
    lines[lineNumber] = prependString .. lines[lineNumber]
  end

  -- Seek to the beginning of the file
  file:seek("set")

  -- Write the modified lines back to the file
  for _, line in ipairs(lines) do
    file:write(line .. "\n")
  end

  -- Close the file
  file:close()
end

function isFileLongEnough(filename, minLines)
  -- Open the file
  local file = io.open(filename, "r")

  -- Check if the file was opened successfully
  if not file then
    print("Error opening the file.")
    return false
  end

  -- Read the lines and count them
  local lineCount = 0
  for _ in file:lines() do
    lineCount = lineCount + 1
    if lineCount >= minLines then
      break
    end
  end

  -- Close the file
  file:close()

  -- Check if the line count meets the minimum requirement
  return lineCount >= minLines
end

win:show()
repeat
	ui.update()
  list:clear()
  for line in io.lines(input) do
    lineNum = lineNum + 1
    prependStringToLine("orion.txt", lineNum, "["..os.date().."] ")
    list:add(line)
  end
  if isFileLongEnough("orion.txt", 18) then
    os.execute("del orion.txt")
    os.execute("echo. > orion.txt")
  end
until not win.visible
os.execute("del "..input)
os.execute("echo Loaded custom orionAPI connection config. > "..input)