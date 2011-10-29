local curDetail = 1

lines = display.newGroup()

function drawLightning(x1, y1, x2, y2, displace, r, g, b)
	if displace < curDetail then

		--glow around lightning
		for i = 1, 4 do
			line = display.newLine(x1, y1, x2, y2)
			line:setColor(r, g, b)
			line.width = 20 / i
			line.alpha = 0.05 * i
			lines:insert(line)
		end
		
		--bolt itself
		line = display.newLine(x1, y1, x2, y2)
		line:setColor(r, g, b)
		line.width = 2
		lines:insert(line)
		
	else
		local midx = (x2+x1)/2
		local midy = (y2+y1)/2
		midx = midx + (math.random(0, 1) - 0.5)*displace
		midy = midy + (math.random(0, 1) - 0.5)*displace
		drawLightning(x1, y1, midx, midy, displace/2, r, g, b)
		drawLightning(x2, y2, midx, midy, displace/2, r, g, b)
	end
end

local function ontouch(e)
	if e.phase == 'began' then
		drawLightning(0, 0, e.x, e.y, 100, 255, 255, 255)
		timer.performWithDelay(500, function() display.getCurrentStage():remove(1); lines = display.newGroup() end)
	end
end

Runtime:addEventListener('touch', ontouch)