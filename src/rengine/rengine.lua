local ui = require("ui")
local canvas = require("canvas")

local win = ui.Window("server nuker 5000", "fixed", 500, 500)
  win:loadicon("rengine.ico")
local dbg = ui.Window("rengine - debug", "fixed", 500, 500)
local engine = ui.Canvas(win)

engine.align = "all"

function makeCube(x, y, scale)
  if x == nil then x = engine.width/2 end
  if y == nil then y = engine.height/2 end
  if scale == nil then scale = 100 end
  
  local values = {
    r1 = {
      a = x-(scale-math.ceil(scale/4));
      b = y-(scale-math.ceil(scale/4));
      c = x+(scale-math.ceil(scale/2));
      d = y+(scale-math.ceil(scale/2));
    };
    r2 = {
      a = x+(scale-math.ceil(scale/4));
      b = y+(scale-math.ceil(scale/4));
      c = x-(scale-math.ceil(scale/2));
      d = y-(scale-math.ceil(scale/2));
    };
    
    l1 = {
      a = x-(scale-math.ceil(scale/4))
      b = y-(scale-math.ceil(scale/4))
      c = x-(scale-math.ceil(scale/2))
      d = y-(scale-math.ceil(scale/2))
    };
    l2 = {
      a = x+(scale-math.ceil(scale/4));
      b = y+(scale-math.ceil(scale/4));
      c = x+(scale-math.ceil(scale/2));
      d = y+(scale-math.ceil(scale/2));
    };
    l3 = {
      a = x-(scale-math.ceil(scale/4))+(scale+math.floor(scale/4));
      b = y-(scale-math.ceil(scale/4));
      c = x-(scale-math.ceil(scale/2))+(scale+math.floor(scale/4));
      d = y-(scale-math.ceil(scale/2));
    };
    l4 = {
      a = x+(scale-math.ceil(scale/4))-(scale+math.floor(scale/4));
      b = y+(scale-math.ceil(scale/4));
      c = x+(scale-math.ceil(scale/2))-(scale+math.floor(scale/4));
      d = y+(scale-math.ceil(scale/2));
    };
  };
  
  engine:begin()
  
  --rect1 engine:rect(x-(scale-math.ceil(scale/4)), y-(scale-math.ceil(scale/4)), x+(scale-math.ceil(scale/2)), y+(scale-math.ceil(scale/2)))
  --rect2 engine:rect(x+(scale-math.ceil(scale/4)), y+(scale-math.ceil(scale/4)), x-(scale-math.ceil(scale/2)), y-(scale-math.ceil(scale/2)))
  
  --ln1 engine:line(x-(scale-math.ceil(scale/4)), y-(scale-math.ceil(scale/4)), x-(scale-math.ceil(scale/2)), y-(scale-math.ceil(scale/2)))
  --ln2 engine:line(x+(scale-math.ceil(scale/4)), y+(scale-math.ceil(scale/4)), x+(scale-math.ceil(scale/2)), y+(scale-math.ceil(scale/2)))
  --ln3 engine:line(x-(scale-math.ceil(scale/4))+(scale+math.floor(scale/4)), y-(scale-math.ceil(scale/4)), x-(scale-math.ceil(scale/2))+(scale+math.floor(scale/4)), y-(scale-math.ceil(scale/2)))
  --ln4 engine:line(x+(scale-math.ceil(scale/4))-(scale+math.floor(scale/4)), y+(scale-math.ceil(scale/4)), x+(scale-math.ceil(scale/2))-(scale+math.floor(scale/4)), y+(scale-math.ceil(scale/2)))
  
  engine:flip()


end

makeCube(engine.width/2, engine.height/2, 200)

function

win:show()

repeat
  ui.update()
  
until not win.visible