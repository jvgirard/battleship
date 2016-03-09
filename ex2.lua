local WIDTH, HEIGHT = canvas:attrSize ()
local ship_spawn={}
local count=0
local GRID = {
  h_cells = 10,        -- num of horizontal cells
  v_cells = 10,        -- num of vertical cells
  cell_size = 40,      -- cell size in pixels
  color = 'yellow',    -- grid color
}

local function draw_grid ()
  local w = GRID.h_cells * GRID.cell_size
  local h = GRID.v_cells * GRID.cell_size
  if w > WIDTH or h > HEIGHT then
    error ("grid is too big for window")
  end
  canvas:attrColor (GRID.color)
  local x0, y0 = (WIDTH-w)/2, (HEIGHT-h)/2
  canvas:drawRect ('frame', x0, y0, w, h)
  for i=1,GRID.h_cells do
    local x1 = x0 + GRID.cell_size * i
    local y1 = y0
    local x2 = x1
    local y2 = y1 + h
    canvas:drawLine (x1, y1, x2, y2)
  end
  for i=1,GRID.v_cells do
    local x1 = x0
    local y1 = y0 + GRID.cell_size * i
    local x2 = x1 + w
    local y2 = y1
    canvas:drawLine (x1, y1, x2, y2)
  end
  canvas:flush ()
end

local function get_cell (x, y)
  local i, j = 0, 0
  for t=0,9,1 do 
    if x>200+GRID.cell_size*t and x<240+GRID.cell_size*t then
      i=t+1
    end
  end
  for t=0,9,1 do 
    if y>100+GRID.cell_size*t and y<140+GRID.cell_size*t then
      j=t+1
    end
  end
  return i, j
end

draw_grid ()

local function draw_ship(x,y)
  canvas:attrColor ('orange')
  canvas:drawRect("fill",x,y,40,40)
  canvas:flush()
end

event.register (
  function (e)
    local i, j = get_cell (e.x, e.y)
    print (('%d,%d->%d,%d'):format (e.x,e.y,i,j))
  end,
  {class='pointer', type='move'}
)
event.register ( -- checks the mouse clicks to create a ship
  function (e)
    local i, j = get_cell (e.x, e.y)    
    if(i~=0 and j~=0) then
      --[[for q=1,q<count,2 do
        if ship_spawn[q]~= 200+40*(i-1) and ship_spawn[q+1]~=100+40*(j-1) then--]]
          draw_ship(200+40*(i-1),100+40*(j-1))
         --[[end 
        end]]--
    end
  end,
  {class='pointer', type='press'}
)