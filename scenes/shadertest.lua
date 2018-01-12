local shaderTestScene = scenes.loadscene("scene")

function shaderTestScene.load()
  myShader = love.graphics.newShader[[
		extern number factor = 0;
		vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
			vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color 
			        
			number average = (pixel.r+pixel.b+pixel.g)/3.0;

			pixel.r = pixel.r + (average-pixel.r) * factor;
			pixel.g = pixel.g + (average-pixel.g) * factor;
			pixel.b = pixel.b + (average-pixel.b) * factor; 


			return pixel;	
		}
	]]
  pic = love.graphics.newImage("test.png")
  time = 0;
end

function shaderTestScene.update(dt)
  time = time + dt;
	local factor = math.abs(math.cos(time)); --so it keeps going/repeating
	myShader:send("factor",factor)
end


function shaderTestScene.keypressed( key, unicode )
  if key == "escape" then
    -- go back to the front screen
    scenes.setCurrent(game_structure["front"])
  end
end

function shaderTestScene.draw()
  love.graphics.setBackgroundColor(22,28,22)
  love.graphics.setShader(myShader)
  love.graphics.draw(pic,250,100)
	love.graphics.setShader()
  love.graphics.setFont(smfont)
  love.graphics.print("Press ESC to go back", 300, 5)
  love.graphics.setFont(regularfont)
end

return shaderTestScene