local ui = require("ui")
local audio = require "audio"

local win = ui.Window("mello", "fixed", 600, 400)

local subfive = ui.Button(win, "-5", 225, 350, 30, 30)
local prevsong = ui.Button(win, "<|", 255, 350, 30, 30)
local play = ui.Button(win, "||", 285, 350, 30, 30)
local nextsong = ui.Button(win, "|>", 315, 350, 30, 30)
local addfive = ui.Button(win, "+5", 345, 350, 30, 30)

local pb = ui.Progressbar(win, true, 10, 320, 580, 10)
pb.fgcolor = 0xffd966

function addfive:onClick()
  pb:advance(5)
end
function subfive:onClick()
  pb:advance(-5)
end


win:show()

repeat
  ui.update()
until not win.visible