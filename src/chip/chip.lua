local ui = require("ui")

local win = ui.Window("chip", "fixed", 500, 400)
win:loadicon("ico.ico")

local tab = ui.Tab(win, {"Events", "Outputs", "Inputs", "Variables"}, 0, 0, win.width, win.height)
  tab.align = "all"

local events_list = ui.List(tab.items["Events"], {}, 10, 10, 200, 300)
local compile = ui.Button(tab.items["Events"], "Compile", 10, events_list.x+5+events_list.height, events_list.width, 55)
  compile.tooltip = "Compiles all events and bindings into a chip executable."
  


local events_cmd_in = ui.Entry(tab.items["Events"], "echo Hello!", events_list.x+10+events_list.width, 10, 130)
  events_cmd_in.font = "Cascadia Code"
local events_cmd_add = ui.Button(tab.items["Events"], "Add command", events_cmd_in.x+5+events_cmd_in.width, 10, 130)
  events_cmd_add.tooltip = "Add a command to be run in the Command Prompt."
  function events_cmd_add:onClick()
    
  end

local events_delay_in = ui.Entry(tab.items["Events"], "0.5", events_list.x+10+events_list.width, events_cmd_in.y+25, 130)
  events_delay_in.font = "Cascadia Code"
local events_delay_add = ui.Button(tab.items["Events"], "Add delay", events_cmd_in.x+5+events_cmd_in.width, events_cmd_in.y+25, 130)
  events_delay_add.tooltip = "Adds a delay between events."

local events_input_in = ui.Combobox(tab.items["Events"], false, {""}, events_list.x+10+events_list.width, events_delay_add.y+25, 130)
local events_input_add = ui.Button(tab.items["Events"], "Add input", events_cmd_in.x+5+events_cmd_in.width, events_delay_in.y+25, 130)
  events_input_add.tooltip = "Prompts the user with an input."

local events_output_in = ui.Combobox(tab.items["Events"], false, {""}, events_list.x+10+events_list.width, events_input_add.y+25, 130)
local events_output_add = ui.Button(tab.items["Events"], "Add output", events_cmd_in.x+5+events_cmd_in.width, events_input_in.y+25, 130)
  events_output_add.tooltip = "Shows a popup to the user displaying text."

win:show()
repeat
  ui.update()
until not win.visible