local ui = require "ui"
local win = ui.Window("orionAPI - A shared console window", "fixed", 520, 400)
local list = ui.List(win, {}, -1, -1, 522, 351)
local lineNum = 0
io.input("orion.txt")

os.execute("del orion.txt")
os.execute("echo orionAPI connection started. > orion.txt")


local clearButton = ui.Button(win, "Clear Log", 451, 361)
function clearButton:onClick()
  os.execute("del orion.txt")
  os.execute("echo. > orion.txt")
end
clearButton.tooltip = "Clears the output log"

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

list:clear()
for line in io.lines("orion.txt") do
    list:add(line)
end

function list:onSelect(item)
	if readLineFromFile("orionDialogue.txt", item.index) == nil then
    ui.info("No advanced description was provided")
  else
    ui.info(readLineFromFile("orionDialogue.txt", item.index))
  end
end

win:show()
repeat
	ui.update()
  list:clear()
  for line in io.lines("orion.txt") do
    lineNum = lineNum + 1
    prependStringToLine("orion.txt", lineNum, "["..os.date().."] ")
    list:add(line)
  end
  if isFileLongEnough("orion.txt", 18) then
    os.execute("del orion.txt")
    os.execute("echo. > orion.txt")
  end
until not win.visible
