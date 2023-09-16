local ui = require("ui")

local showhistory = false
local isAnswer = true
local equations = {}

function evaluateEquation(str)
  local equationFunc, errorMsg = load("return " .. str)
  if not equationFunc then
    return nil, "Error parsing the equation: " .. errorMsg
  end
  local success, result = pcall(equationFunc)
  if not success then
    return nil, "Error evaluating the equation: " .. result
  end
  return tostring(result)
end
function getCharacterAfter(str, char)
    local pos = string.find(str, char, 1, true) -- 'true' for plain matching (no pattern)
    if pos then
        return string.sub(str, pos + 1, pos + 1)
    end
end
function power(baseStr, exponentStr)
    local base = tonumber(baseStr)
    local exponent = tonumber(exponentStr)

    if base and exponent then
        return base ^ exponent
    else
        return nil
    end
end

local win = ui.Window("Calculator", "fixed", 400, 500)
local equation = ui.Entry(win, "", 10, 10, win.width-20, math.floor(win.height/6))
  equation.font = "Cascadia Code"
  equation.fontsize = 40
  equation.textalign = "right"
  equation.enabled = false

local add = ui.Button(win, "Add", equation.width+equation.x-50, equation.y+equation.height+10, 50, 40)
  add.hastext = false
  add:loadicon("add.ico")
  add.width = 45
  add.height = 45
  add.enabledStat = false
local subt = ui.Button(win, "Subtract", equation.width+equation.x-50, add.y+add.height+10, 50, 40)
  subt.hastext = false
  subt:loadicon("sub.ico")
  subt.width = 45
  subt.height = 45
  subt.enabledStat = false
local mult = ui.Button(win, "Multiply", equation.width+equation.x-50, subt.y+subt.height+10, 50, 40)
  mult.hastext = false
  mult:loadicon("mult.ico")
  mult.width = 45
  mult.height = 45
  mult.enabledStat = false
local div = ui.Button(win, "Divide", equation.width+equation.x-50, mult.y+mult.height+10, 50, 40)
  div.hastext = false
  div:loadicon("div.ico")
  div.width = 45
  div.height = 45
  div.enabledStat = false

local historytray = ui.List(win, {}, add.x+add.width+15, 10, 190, 413)
  historytray.font = "Cascadia Code"
  function historytray:onSelect(item)
    ui.msg(item.text)
  end

function add:onClick()
  if add.enabledStat then equation.text = equation.text.."+"; div.enabledStat, mult.enabledStat, add.enabledStat, subt.enabledStat = false, false, false, false end
  isAnswer = false
end
function mult:onClick()
  if mult.enabledStat then equation.text = equation.text.."*"; div.enabledStat, mult.enabledStat, add.enabledStat, subt.enabledStat = false, false, false, false end
  isAnswer = false
end
function subt:onClick()
  if subt.enabledStat then equation.text = equation.text.."-"; div.enabledStat, mult.enabledStat, add.enabledStat, subt.enabledStat = false, false, false, false end
  isAnswer = false
end
function div:onClick()
  if div.enabledStat then equation.text = equation.text.."/"; div.enabledStat, mult.enabledStat, add.enabledStat, subt.enabledStat = false, false, false, false end
  isAnswer = false
end

local equals = ui.Button(win, "Equals", equation.width+equation.x-50, div.y+div.height+10, 50, 50)
  equals.hastext = false
  equals:loadicon("equals.ico")
  equals.width = 45
  equals.height = 100
  function equals:onClick()
    historytray:add(equation.text.." = "..evaluateEquation(equation.text))
    equation.text = evaluateEquation(equation.text)
    isAnswer = true
  end

local one = ui.Button (win, "1", 10, equation.height+equation.y+10, 100, 100)
  one.fontsize = 20
  function one:onClick()
    if isAnswer == true then equation.text = "1"; isAnswer = false else equation.text = equation.text.."1" end
    div.enabledStat, mult.enabledStat, add.enabledStat, subt.enabledStat = true, true, true, true
  end
local two = ui.Button (win, "2", one.x+one.width+10, equation.height+equation.y+10, 100, 100)
  two.fontsize = 20
  function two:onClick()
    if isAnswer == true then equation.text = "2"; isAnswer = false else equation.text = equation.text.."2" end
    div.enabledStat, mult.enabledStat, add.enabledStat, subt.enabledStat = true, true, true, true
  end
local thr = ui.Button (win, "3", two.x+two.width+10, equation.height+equation.y+10, 100, 100)
  thr.fontsize = 20
  function thr:onClick()
    if isAnswer == true then equation.text = "3"; isAnswer = false else equation.text = equation.text.."3" end
    div.enabledStat, mult.enabledStat, add.enabledStat, subt.enabledStat = true, true, true, true
  end
local fou = ui.Button (win, "4", 10, equation.height+equation.y+120, 100, 100)
  fou.fontsize = 20
  function fou:onClick()
    if isAnswer == true then equation.text = "4"; isAnswer = false else equation.text = equation.text.."4" end
    div.enabledStat, mult.enabledStat, add.enabledStat, subt.enabledStat = true, true, true, true
  end
local fiv = ui.Button (win, "5", two.x, fou.y, 100, 100)
  fiv.fontsize = 20
  function fiv:onClick()
    if isAnswer == true then equation.text = "5"; isAnswer = false else equation.text = equation.text.."5" end
    div.enabledStat, mult.enabledStat, add.enabledStat, subt.enabledStat = true, true, true, true
  end
local six = ui.Button (win, "6", thr.x, fou.y, 100, 100)
  six.fontsize = 20
  function six:onClick()
    if isAnswer == true then equation.text = "6"; isAnswer = false else equation.text = equation.text.."6" end
    div.enabledStat, mult.enabledStat, add.enabledStat, subt.enabledStat = true, true, true, true
  end
local sev = ui.Button (win, "7", 10, equation.height+equation.y+230, 100, 100)
  sev.fontsize = 20
  function sev:onClick()
    if isAnswer == true then equation.text = "7"; isAnswer = false else equation.text = equation.text.."7" end
    div.enabledStat, mult.enabledStat, add.enabledStat, subt.enabledStat = true, true, true, true
  end
local eig = ui.Button (win, "8", fiv.x, sev.y, 100, 100)
  eig.fontsize = 20
  function eig:onClick()
    if isAnswer == true then equation.text = "8"; isAnswer = false else equation.text = equation.text.."8" end
    div.enabledStat, mult.enabledStat, add.enabledStat, subt.enabledStat = true, true, true, true
  end
local nin = ui.Button (win, "9", six.x, sev.y, 100, 100)
  nin.fontsize = 20
  function nin:onClick()
    if isAnswer == true then equation.text = "9"; isAnswer = false else equation.text = equation.text.."9" end
    div.enabledStat, mult.enabledStat, add.enabledStat, subt.enabledStat = true, true, true, true
  end
local zer = ui.Button (win, "0", eig.x, nin.y+nin.height+10, 100, 50)
  zer.fontsize = 20
  function zer:onClick()
    if isAnswer == true then equation.text = "0"; isAnswer = false else equation.text = equation.text.."0" end
    div.enabledStat, mult.enabledStat, add.enabledStat, subt.enabledStat = true, true, true, true
  end
  
local clr = ui.Button(win, "Clear", sev.x, nin.y+nin.height+10, 100, 50)
  clr.hastext = false
  clr:loadicon("delete.ico")
  clr.height = 50
  clr.width = 100
  function clr:onClick()
    equation.text = ""
  end
local del = ui.Button(win, "Backspace", nin.x, nin.y+nin.height+10, 100, 50)
  del.hastext = false
  del:loadicon("backspace.ico")
  del.height = 50
  del.width = 100
  function del:onClick()
    equation.text = string.sub(equation.text, 1, -2)
  end
local menu = ui.Button(win, "History", equation.width+equation.x-50, equals.y+equals.height+10, 50, 50)
menu.hastext = false
menu:loadicon("menu.ico")
menu.width = 45
menu.height = 50
  function menu:onClick()
    showhistory = not showhistory
    if showhistory == true then
      win.width = 600
    else
      win.width = 400
    end
  end

function win:onKey(key)
  if key == "VK_NUMPAD1" then
      one:onClick()
    elseif key == "VK_NUMPAD2" then
      two:onClick()
    elseif key == "VK_NUMPAD3" then
      thr:onClick()
    elseif key == "VK_NUMPAD4" then
      fou:onClick()
    elseif key == "VK_NUMPAD5" then
      fiv:onClick()
    elseif key == "VK_NUMPAD6" then
      six:onClick()
    elseif key == "VK_NUMPAD7" then
      sev:onClick()
    elseif key == "VK_NUMPAD8" then
      eig:onClick()
    elseif key == "VK_NUMPAD9" then
      nin:onClick()
    elseif key == "VK_NUMPAD0" then
      zer:onClick()
    elseif key == "VK_MULTIPLY" then
      mult:onClick()
    elseif key == "VK_SUBTRACT" then
      subt:onClick()
    elseif key == "VK_DIVIDE" then
      div:onClick()
    elseif key == "VK_ADD" then
      add:onClick()
    elseif key == "VK_RETURN" then
      equals:onClick()
    elseif key == "VK_DECIMAL" then
      del:onClick()
    elseif key == "M" then
      history:onClick()
      console.writeln("["..os.date().."] key: "..key)
    elseif key == "VK_OEM_PERIOD" then
      if add.enabledStat then equation.text = equation.text.."."; div.enabledStat, mult.enabledStat, add.enabledStat, subt.enabledStat = false, false, false, false end
      isAnswer = false
    elseif key == "0" then
      equation.text = equation.text..")"
      isAnswer = false
    elseif key == "9" then
      equation.text = equation.text.."("
      isAnswer = false
    elseif key == "VK_MENU" then
      local menu = ui.Menu("Square", "Cube", "Round", "Sine", "Cosine", "Tangent", "Square Root", "Power")
      function menu:onClick(item)
        if item.text == "Square" then
          historytray:add(equation.text.."² = "..evaluateEquation(equation.text.."*"..equation.text))
          equation.text = evaluateEquation(equation.text.."*"..equation.text)
          isAnswer = true
        elseif item.text == "Cube" then
          historytray:add(equation.text.."³ = "..evaluateEquation(equation.text.."*"..equation.text.."*"..equation.text))
          equation.text = evaluateEquation(equation.text.."*"..equation.text.."*"..equation.text)
          isAnswer = true
        elseif item.text == "Round" then
          local result = ""
          if getCharacterAfter(equation.text, ".") == "0" then result = tostring(math.floor(equation.text)) end
          if getCharacterAfter(equation.text, ".") == "1" then result = tostring(math.floor(equation.text)) end
          if getCharacterAfter(equation.text, ".") == "2" then result = tostring(math.floor(equation.text)) end
          if getCharacterAfter(equation.text, ".") == "3" then result = tostring(math.floor(equation.text)) end
          if getCharacterAfter(equation.text, ".") == "4" then result = tostring(math.floor(equation.text)) end
          if getCharacterAfter(equation.text, ".") == "5" then result = tostring(math.ceil(equation.text)) end
          if getCharacterAfter(equation.text, ".") == "6" then result = tostring(math.ceil(equation.text)) end
          if getCharacterAfter(equation.text, ".") == "7" then result = tostring(math.ceil(equation.text)) end
          if getCharacterAfter(equation.text, ".") == "8" then result = tostring(math.ceil(equation.text)) end
          if getCharacterAfter(equation.text, ".") == "9" then result = tostring(math.ceil(equation.text)) end
          historytray:add("round("..equation.text..") = "..result)
          equation.text = result
          isAnswer = true
        elseif item.text == "Sine" then
          historytray:add("sin("..equation.text..") = "..tostring(math.sin(equation.text)))
          equation.text = tostring(math.sin(equation.text))
          isAnswer = true
        elseif item.text == "Cosine" then
          historytray:add("cos("..equation.text..") = "..tostring(math.cos(equation.text)))
          equation.text = tostring(math.cos(equation.text))
          isAnswer = true
        elseif item.text == "Tangent" then
          historytray:add("tan("..equation.text..") = "..tostring(math.tan(equation.text)))
          equation.text = tostring(math.tan(equation.text))
          isAnswer = true
        elseif item.text == "Square Root" then
          historytray:add("sqrt("..equation.text..") = "..tostring(math.sqrt(equation.text)))
          equation.text = tostring(math.sqrt(equation.text))
          isAnswer = true
        elseif item.text == "Power" then
          local dialogue = ui.Window("Calculator - Power", "fixed", 200, 100)
          local input = ui.Entry(dialogue, "2", 10, 0, 180, 50)
            input.font = "Cascadia Code"
            input.fontsize = 24
          local ok = ui.Button(dialogue, "Ok", 10, 60, 85)
          local cancel = ui.Button(dialogue, "Cancel", 105, 60, 85)
          win:showmodal(dialogue)
          function ok:onClick()
            historytray:add("pwr("..equation.text..", "..input.text..") = "..tostring(power(equation.text, input.text)))
            equation.text = tostring(power(equation.text, input.text))
            isAnswer = true
            dialogue:hide()
          end
          function cancel:onClick() dialogue:hide() end
        end
      end
      win:popup(menu)
    end
  end

win:show()
repeat
  ui.update()
until not win.visible