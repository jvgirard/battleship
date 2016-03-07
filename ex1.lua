w,h = canvas:attrSize ()
local BACK = canvas:new (w,h)
  BACK:attrColor ('black')
  BACK:clear ()
  canvas:compose (0, 0, BACK)
  canvas:flush ()
-- GRID --
local function grid ()
  canvas:attrColor ('red')
  for i=0,800,40 do 
    canvas:drawRect ('fill',8+i,0,5,285)
  end
  for i=0,285,40 do
    canvas:drawRect ('fill',8,0+i,765,5)
  end
  canvas:flush()
  canvas:attrColor ('green')
  for i=0,800,40 do 
    canvas:drawRect ('fill',8+i,285,5,285)
  end
  for i=0,560,40 do 
    canvas:drawRect ('fill',8,285+i,765,5)
  end
  canvas:flush()
end
grid()

-- CLEAR GRID --
local function clean () 
  local BACK = canvas:new (w,h)
  BACK:attrColor ('black')
  BACK:clear ()
  canvas:compose (0, 0, BACK)
  canvas:flush ()
end

-- BOAT SET UP --
local dx,dy,t
dx=0
dy=0
t=1
handlerBarco = function (evt)
  canvas:attrColor ('yellow')
  canvas:drawRect ('fill',8+dx,285+dy,40,40)
  canvas:flush()
  --selection
  px={}
  py={}
  if  evt.key == 'ENTER'    then
    px[t]=dx
    py[t]=dy
    t= t+1
    
  end
  function redraw()
    local i
    if t>1 then
      for i=1,t,1 do
       canvas:drawRect ('fill',8+px[1],285+py[1],40,40)
        canvas:drawRect ('fill',8+px[2],285+py[2],40,40)
        canvas:flush()
      end
    end
  end  
  local function press (evt)
   redraw ( dx, dy)
   canvas:compose (0, 0, BACK)
   canvas:flush ()
end
assert (event.register (press, {class='pointer', type='press'}))
  -- movement
  if  evt.key == 'CURSOR_UP'    then
    dy = dy - 40
    clean()
    press (evt)
    grid()
    redraw()
  elseif evt.key == 'CURSOR_DOWN'  then
    dy = dy + 40
    clean()
    press (evt)
    grid()
    redraw()
  elseif evt.key == 'CURSOR_LEFT'  then
    dx = dx - 40
    clean()
    press (evt)
    grid()
    redraw()
  elseif evt.key == 'CURSOR_RIGHT' then
    dx = dx + 40
    clean()
    press (evt)
    grid()
    redraw()
  end
end     
event.register(handlerBarco)


--[[local nave
local DX, DY = canvas:attrSize()
local DRAWS = {}

function redraw ()
   canvas:attrColor('black')
   canvas:drawRect('fill', 0, 0, DX, DY)
    for _, draw in ipairs(DRAWS) do
        draw:draw()
    end
    canvas:flush()
end

function drawImage (self)
    if self.frame then
        local x = self.frame * self.dx
        canvas:compose(self.x, self.y, self.cvs, x,0,self.dx,self.dy)
    else
        canvas:compose(self.x, self.y, self.cvs)
    end
end

barco={
  barco=true,
  img=canvas:new('barco.png'),
  draw= drawImage,
}
local dx, dy = barco.img:attrSize()
    barco.x  = (DX - dx) / 2
    barco.y  = (DY - dy) / 2
    barco.dx = dx
    barco.dy = dy

DRAWS[#DRAWS+1] = barco
canvas:flush()
--[[function handler (e)
   if e.class == 'pointer' then 
	canvas:attrColor ('white')
	for i=0,800,40 do 
	canvas:drawRect ('fill',8+i,0,5,900)
	canvas:drawRect ('fill',8,0+i,900,5)
	end
	canvas:flush()
   return end
end 

event.register (hacanvas:drawndler)--]]

--[[local function handler (e)
   if e.class == 'tick' then return end
   for k,v in pairs (e) do print (k,v) end
end
event.register (handler)--]]
