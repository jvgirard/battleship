w,h = canvas:attrSize ()
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

local dx,dy = 0
canvas:attrColor ('yellow')
canvas:drawRect ('fill',8+dx,285+dy,40,40)
canvas:flush()


 handlerBarco = function (evt)
   -- movimentos
		    if     evt.key == 'CURSOR_UP'    then
                dy = dy - 40
		    elseif evt.key == 'CURSOR_DOWN'  then
                dy = dy + 40
		    elseif evt.key == 'CURSOR_LEFT'  then
                dx = dx - 40
		    elseif evt.key == 'CURSOR_RIGHT' then
                dx = dx + 40
		    end 
        canvas:drawRect ('fill',8+dx,285+dy,40,40)
			     canvas:flush()
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
