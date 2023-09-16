local ui = require("ui")
local minimized = false
local doing = false

local win = ui.Window("ember Editor", 700, 500)
  win:loadicon("main.ico")
local script = ui.Edit(win, "", 0, 0)
  script.font = "Cascadia Code"
local tree = ui.Tree(win, {"main.src", ["components"] = {"ember", "io", "file", "str", "math", "compiler"}, ["internals"] = {"ver.edat", "manifest.edat", "config.edat"}}, 0, 0, 0, win.height-150)
  tree.style = "icons"
  tree.items["main.src"]:loadicon("script.ico")
  tree.items["components"]:loadicon("componentfolder.ico")
    tree.items["components"].subitems["ember"]:loadicon("main.ico")
    tree.items["components"].subitems["io"]:loadicon("component.ico")
    tree.items["components"].subitems["file"]:loadicon("component.ico")
    tree.items["components"].subitems["str"]:loadicon("component.ico")
    tree.items["components"].subitems["math"]:loadicon("component.ico")
    tree.items["components"].subitems["compiler"]:loadicon("component.ico")
  tree.items["internals"]:loadicon("internals.ico")
    tree.items["internals"].subitems["ver.edat"]:loadicon("component.ico")
    tree.items["internals"].subitems["manifest.edat"]:loadicon("component.ico")
    tree.items["internals"].subitems["config.edat"]:loadicon("component.ico")
local showtree = ui.Checkbox(win, "Show project menu", 10, tree.height+10)
  showtree.checked = true
  tree.width = 200
  script.height = win.height-50
  script.width = win.width-tree.width-20
  script.x = tree.x+tree.width+10

local run = ui.Button(win, "Run", showtree.x+showtree.width+10, showtree.y, win.width/7)
local compile  = ui.Button(win, "Compile", run.width+run.x+10, showtree.y, win.width/7)

local addscript = ui.Button(win, "Add Script", 10, tree.y+tree.height+10, tree.width-20)
  addscript:loadicon("script.ico")
  addscript.width = tree.width-20
local addres = ui.Button(win, "Add Resource", 10, addscript.y+addscript.height+5, tree.width-20)
  addres:loadicon("res.ico")
  addres.width = tree.width-20
local del = ui.Button(win, "Delete", 10, addres.y+addres.height+5, tree.width-20)

function showtree:onClick()
  if showtree.checked == true then
    tree.width = 200
    script.height = win.height-50
    script.width = win.width-tree.width-20
    script.x = tree.x+tree.width+10
  else
    tree.width = 0
    script.height = win.height-50
    script.width = win.width-tree.width-20
    script.x = tree.x+tree.width+10
  end
end

function minimizeWin()
  minimized = not minimized
  if minimized == true then
    win.height = 0 
  end
  if minimized == false then
    win.height = 500
  end
end
win:shortcut("1", minimizeWin, false, false, true)

function showtreefunc()
  showtree.checked = not showtree.checked
  if showtree.checked == true then
    tree.width = 200
    script.height = win.height-50
    script.width = win.width-tree.width-20
    script.x = tree.x+tree.width+10
  else
    tree.width = 0
    script.height = win.height-50
    script.width = win.width-tree.width-20
    script.x = tree.x+tree.width+10
  end
end
win:shortcut("2", showtreefunc, false, false, true)

function win:onResize()
  script.height = win.height-50; script.width = win.width-tree.width-20; script.x = tree.x+tree.width+10
  tree.height = win.height-150; showtree.y = tree.height+110
  
  run.y = showtree.y; run.width = win.width/7
  compile.y = showtree.y; compile.x = run.x+run.width+5; compile.width = win.width/7
 
  
  addscript.y = tree.y+tree.height+10; addscript.width = tree.width-20
  addres.y = addscript.y+addscript.height+5; addres.width = tree.width-20
  del.y = addres.y+addres.height+5; del.width = tree.width-20
end

function tree:onDoubleClick(item)
  if item.text == "Vanguard" then
    script.text = io.input("content\\component_vanguard.vcomp"):read("*a")
  elseif item.text == "io" then
    script.text = io.input("content\\component_io.vcomp"):read("*a")
  elseif item.text == "str" then
    script.text = io.input("content\\component_str.vcomp"):read("*a")
  elseif item.text == "math" then
    script.text = io.input("content\\component_math.vcomp"):read("*a")
  elseif item.text == "file" then
    script.text = io.input("content\\component_file.vcomp"):read("*a")
  elseif item.text == "ver.vdat" then
    script.font = "Arial"
    script.text = io.input("content\\internals.vdat"):read("*a")
  end
end

win:show()

repeat
  ui.update()
until not win.visible