local frontScene = scenes.loadscene("scene")

function frontScene.load()
end

function frontScene.keypressed( key, unicode )
  print(key)
  if key == "a" then
    -- start audio test scene
    scenes.setCurrent(game_structure["audiotest"])
    frontScene.pause()
  end
end

function frontScene.draw()
  love.graphics.setBackgroundColor(255, 255, 255)
  love.graphics.setColor(0,0,0)
  love.graphics.setFont(lrgfont)
  love.graphics.print("Press a for the audio test screen", 30, love.graphics.getHeight()/2)
end

return frontScene