local ui = require("ui")
local selectednote = ""

local win = ui.Window("notely", "fixed", 540, 400)
local note = ui.Edit(win, "", 10, 200, 300, 190)
note.wordwrap = true
local title = ui.Entry(win, "Title", 10, 10, 300)
local desc = ui.Edit(win, "Description", 10, 40, 300, 120)
local add = ui.Button(win, "Add Note", 10, 165, 300)
local notes = ui.List(win, {}, 320, 10, 210, 350)
notes.style = "icons"
local status = ui.Checkbox(win, "Done?", 320, 365)
local del = ui.Button(win, "Delete Note", 380, 365, 150)

status.enabled = false
del.enabled = false

for line in io.lines("notes\\index") do
  notes:add(line)
  notes.items[line]:loadicon("res\\false.ico")
end
notes.items["notely "]:loadicon("res\\orange.ico")

function add:onClick()
  if notes.items[title.text] == nil then
    notes:add(title.text)
    notes.items[title.text]:loadicon("res\\false.ico")
    sys.cmd("echo "..title.text.." >> notes\\index", true)
    io.open("notes\\"..title.text..".txt", "w"):write(desc.text)
    note.text = desc.text
  else
    ui.warn("Invalid note name")
  end
end

function del:onClick()
  os.remove("notes\\"..notes.selected.text..".txt")
  io.open("notes\\index", "w"):write(string.gsub(io.open("notes\\index", "r"):read(), notes.selected.text, ""))
  sys.sleep(1)
  notes:remove(notes.selected)
end

function notes:onSelect(item)
  selectednote = item
  status.enabled = true
  del.enabled = true
  note:load(sys.File("notes\\"..string.sub(item.text, 1, #item.text-1)..".txt"))
  if item.text == "notely " then
    io.open("notes\\notely.txt", "w"):write(io.open("sample_note.txt", "r"):read("*a"))
    note.readonly = true
    status.enabled = false
    del.enabled = false
    notes.items["notely "]:loadicon("res\\orange.ico")
  else
    note.readonly = false
  end
end

function status:onClick()
  if status.checked == true then
    notes.selected:loadicon("res\\true.ico")
  else
    notes.selected:loadicon("res\\false.ico")
  end
end

function note:onContext()
  local menu = ui.Menu("Separate", "Toggle wordwrap", "Save", "Show note variables and their states")
  win:popup(menu)
  function menu:onClick(item)
    if item.text == "Separate" then
      local dialogue = ui.Window(note.text, 500, 500)
      local text = ui.Edit(dialogue, note.text)
      text.readonly = true
      text.align = "all"
      win:showmodal(dialogue)
    elseif item.text == "Toggle wordwrap" then
      note.wordwrap = not note.wordwrap
    elseif item.text == "Show note variables and their states" then
      ui.msg("Coming soon...")
    elseif item.text == "Save" and selectednote.text == not "notely" then
      io.open("notes\\"..string.sub(selectednote.text, 1, #selectednote.text-1)..".txt", "w"):write(note.text)
    end
  end
end

function note:onChange()
  io.open("notes\\"..string.sub(selectednote.text, 1, #selectednote.text-1)..".txt", "w"):write(note.text)
end

win:show()

repeat
  if notes.selected == nil then status.enabled = false; del.enabled = false end
  if notes.count == 1 then win.title = "notely - "..tostring(notes.count).." note" else win.title = "notely - "..tostring(notes.count).." notes" end
  ui.update()
until not win.visible