w,h = canvas:attrSize ()
canvas:attrColor ('red')
for i=0,800,40 do 
canvas:drawRect ('fill',8+i,0,5,900)
canvas:drawRect ('fill',8,0+i,900,5)
end
canvas:flush()

--[[local function handler (e)
   if e.class == 'tick' then return end
   for k,v in pairs (e) do print (k,v) end
end
event.register (handler)--]]
