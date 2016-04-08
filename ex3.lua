local WIDTH, HEIGHT = canvas:attrSize ()
STATE = "pre_game_1"
TAB_1={
  {"~","~","~","~","~"},
  {"~","~","~","~","~"},
  {"~","~","~","~","~"},
  {"~","~","~","~","~"},
  {"~","~","~","~","~"},
}
TAB_2={
  {"~","~","~","~","~"},
  {"~","~","~","~","~"},
  {"~","~","~","~","~"},
  {"~","~","~","~","~"},
  {"~","~","~","~","~"},
}
local GRID = {
  h_cells = #TAB_1[1],   -- num of horizontal cells
  v_cells = #TAB_1,      -- num of vertical cells
  cell_size = 40,      -- cell size in pixels
  color = 'yellow',    -- grid color
  total=#TAB_1[1]*#TAB_1*2   -- num of grid cells
}
BOATS_NUM_1=0
BOATS_NUM_2=0
WIDTH_OFF = (WIDTH-GRID.h_cells*GRID.cell_size)/2
HEIGHT_OFF = (HEIGHT-GRID.v_cells*GRID.cell_size)/2
POINTS_1=GRID.total*100
POINTS_2=GRID.total*100
function quit ()
  if POINTS_1< POINTS_2 then
    print("\nPlayer 1 WINS!\n")
  elseif POINTS_1> POINTS_2 then
    print("\nPlayer 2 WINS!\n")
  else
    print("\nIt is a Tie!\n")
  end
  print("Final Ponctuation:\nPlayer1:",POINTS_2,"\nPlayer2:",POINTS_1,"\n")
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
  canvas:drawRect ('frame', x0-w, y0, w, h)
  canvas:drawRect ('frame', x0+w, y0, w, h)
  for i=1,GRID.h_cells do
    local x1 = x0 + GRID.cell_size * i
    local y1 = y0
    local x2 = x1
    local y2 = y1 + h
    canvas:drawLine (x1-w, y1, x2-w, y2)
    canvas:drawLine (x1+w, y1, x2+w, y2)
  end
  for i=1,GRID.v_cells do
    local x1 = x0
    local y1 = y0 + GRID.cell_size * i
    local x2 = x1 + w
    local y2 = y1
    canvas:drawLine (x1-w, y1, x2-w, y2)
    canvas:drawLine (x1+w, y1, x2+w, y2)
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
  local w = GRID.h_cells * GRID.cell_size
  if STATE=="pre_game_1" or STATE=="ingame_1" then
    for t=0,GRID.h_cells-1,1 do 
      if x>WIDTH_OFF+GRID.cell_size*t-w and x<WIDTH_OFF+GRID.cell_size*(t+1)-w then
        i=t+1
      end
    end
    for t=0,GRID.v_cells-1,1 do 
      if y>HEIGHT_OFF+GRID.cell_size*t and y<HEIGHT_OFF+GRID.cell_size*(t+1) then
        j=t+1
      end
    end
  elseif STATE=="pre_game_2" or STATE=="ingame_2" then
    for t=0,GRID.h_cells-1,1 do 
      if x>WIDTH_OFF+GRID.cell_size*t+w and x<WIDTH_OFF+GRID.cell_size*(t+1)+w then
        i=t+1
      end
    end
    for t=0,GRID.v_cells-1,1 do 
      if y>HEIGHT_OFF+GRID.cell_size*t and y<HEIGHT_OFF+GRID.cell_size*(t+1) then
        j=t+1
      end
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
   if STATE=="pre_game_1" or STATE=="ingame_1" then
    canvas:drawRect("fill",X-w,Y,40-GRID.h_cells+3,40-GRID.h_cells+3)
  else
    canvas:drawRect("fill",X+w,Y,40-GRID.h_cells+3,40-GRID.h_cells+3)
  end
  canvas:flush()
end

function redraw()
  draw_grid()
  for i=1, #TAB_1 do
    for j=1, #TAB_1[i] do
      if STATE=="pre_game_1" then
        if TAB_1[i][j]=='~' then
          put_cell(i,j,"blue")
        elseif TAB_1[i][j]=='#' then
          put_cell(i,j,"orange")
        end
      elseif STATE=="pre_game_2" then
        if TAB_2[i][j]=='~' then
          put_cell(i,j,"blue")
        elseif TAB_2[i][j]=='#' then
          put_cell(i,j,"orange")
        end
      elseif STATE=="ingame_1" then
        if TAB_1[i][j]=='~' then
          put_cell(i,j,"gray")
        elseif TAB_1[i][j]=='#' then
          put_cell(i,j,"gray")
        elseif TAB_1[i][j]=='*' then
          put_cell(i,j,"red")
        elseif TAB_1[i][j]=='@' then
          put_cell(i,j,"blue")
        end
      else
        if TAB_2[i][j]=='~' then
          put_cell(i,j,"gray")
        elseif TAB_2[i][j]=='#' then
          put_cell(i,j,"gray")
        elseif TAB_2[i][j]=='*' then
          put_cell(i,j,"red")
        elseif TAB_2[i][j]=='@' then
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
  elseif BOATS_NUM_1<=0 then
    quit()
  elseif BOATS_NUM_2<=0 then
    quit()
  end
end
event.register(function(e)
    if e.key=='q' then
      quit()
    end
    if e.key=='ENTER' then
      if STATE=="pre_game_1" then
        STATE="ingame_1"
        redraw()
        STATE="pre_game_2"
      elseif STATE=="pre_game_2" then
        STATE="ingame_2"
        redraw()
        STATE="ingame_1"
      end
      redraw()
      return
    end
  end,
  {class="key",type="press"})
event.register(function(e)
    local i, j = get_cell (e.x, e.y) 
    if(i~=0 and j~=0) then
      if STATE=="pre_game_1" then
        TAB_1[i][j]='#'
        BOATS_NUM_1=BOATS_NUM_1+1
        redraw()
      elseif STATE=="pre_game_2" then
        TAB_2[i][j]='#'
        BOATS_NUM_2=BOATS_NUM_2+1
        redraw()
      elseif STATE=="ingame_1" then 
        if TAB_1[i][j]=='#' then
          TAB_1[i][j]='*'
          GRID.total=GRID.total-1
          BOATS_NUM_1=BOATS_NUM_1-1
        elseif TAB_1[i][j]=='~' then
          TAB_1[i][j]='@'
          GRID.total=GRID.total-1
          POINTS_1=POINTS_1-100
        end               
        redraw()
        acabou()
        STATE="ingame_2"
        redraw()
      else 
        if TAB_2[i][j]=='#' then
          TAB_2[i][j]='*'
          GRID.total=GRID.total-1
          BOATS_NUM_2=BOATS_NUM_2-1
        elseif TAB_2[i][j]=='~' then
          TAB_2[i][j]='@'
          GRID.total=GRID.total-1
          POINTS_2=POINTS_2-100
        end          
        redraw()
        acabou()
        STATE="ingame_1"
        redraw()
      end
    end
  end,
  {class="pointer",type="press"})