local WIDTH, HEIGHT = canvas:attrSize ()
STATE = "pre_game"
TAB={
  {"~","~","~","~","~"},
  {"~","~","~","~","~"},
  {"~","~","~","~","~"},
  {"~","~","~","~","~"},
  {"~","~","~","~","~"},
}
local GRID = {
  h_cells = #TAB[1],   -- num of horizontal cells
  v_cells = #TAB,      -- num of vertical cells
  cell_size = 40,      -- cell size in pixels
  color = 'yellow',    -- grid color
  total=#TAB[1]*#TAB   -- num of grid cells
}
BOATS_NUM=0
WIDTH_OFF = (WIDTH-GRID.h_cells*GRID.cell_size)/2
HEIGHT_OFF = (HEIGHT-GRID.v_cells*GRID.cell_size)/2
POINTS=GRID.total*100
function quit ()
  print("Final Ponctuation:",POINTS)
  os.exit(0)
end
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
local function draw_ship(x,y)
  canvas:attrColor ('orange')
  canvas:drawRect("fill",x,y,40,40)
  canvas:flush()
end
local function get_cell (x, y)
  local i, j = 0, 0
  for t=0,9,1 do 
    if x>WIDTH_OFF+GRID.cell_size*t and x<WIDTH_OFF+GRID.cell_size*(t+1) then
      i=t+1
    end
  end
  for t=0,9,1 do 
    if y>HEIGHT_OFF+GRID.cell_size*t and y<HEIGHT_OFF+GRID.cell_size*(t+1) then
      j=t+1
    end
  end
  return i, j
end
function put_cell(i,j,color)
  local w=GRID.h_cells*GRID.cell_size
  local h=GRID.v_cells*GRID.cell_size
  local X=(WIDTH-GRID.h_cells)/2+GRID.cell_size*(i-1)-w/2+GRID.h_cells-2
  local Y=(HEIGHT-GRID.v_cells)/2+GRID.cell_size*(j-1)-h/2+GRID.h_cells-2
  canvas:attrColor (color)
  canvas:drawRect("fill",X,Y,40-GRID.h_cells+3,40-GRID.h_cells+3)
  canvas:flush()
end

function redraw()
  draw_grid()
  for i=1, #TAB do
    for j=1, #TAB[i] do
      if STATE=="pre_game" then
        if TAB[i][j]=='~' then
          put_cell(i,j,"blue")
        elseif TAB[i][j]=='#' then
          put_cell(i,j,"orange")
        end
      else
        if TAB[i][j]=='~' then
          put_cell(i,j,"gray")
        elseif TAB[i][j]=='#' then
          put_cell(i,j,"gray")
        elseif TAB[i][j]=='*' then
          put_cell(i,j,"red")
        elseif TAB[i][j]=='@' then
          put_cell(i,j,"blue")
        end
      end
    end
  end
end
redraw()
function acabou()
  if GRID.total<=0 then
    quit()
  elseif BOATS_NUM<=0 then
    quit()
  end
end
event.register(function(e)
    if e.key=='q' then
      quit()
    end
    if e.key=='ENTER' then
      STATE="ingame"
      redraw()
      return
    end
  end,
  {class="key",type="press"})
event.register(function(e)
    local i, j = get_cell (e.x, e.y) 
    if(i~=0 and j~=0) then
      if STATE=="pre_game" then
        TAB[i][j]='#'
        BOATS_NUM=BOATS_NUM+1
        redraw()
      else
        if TAB[i][j]=='#' then
          TAB[i][j]='*'
          GRID.total=GRID.total-1
          BOATS_NUM=BOATS_NUM-1
        elseif TAB[i][j]=='~' then
          TAB[i][j]='@'
          GRID.total=GRID.total-1
          POINTS=POINTS-100
        end
        redraw()
        acabou()
      end
    end
  end,
  {class="pointer",type="press"})
