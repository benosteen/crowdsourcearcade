function love.load()
  require("soundmanager")
  require("scenemanager")
  scenes:setup()
  
  -- fonts
  
  smfont = love.graphics.newFont("font/ARCADECLASSIC.ttf", 26)
  regularfont = love.graphics.newFont("font/ARCADECLASSIC.ttf", 32)
  lrgfont = love.graphics.newFont("font/ARCADECLASSIC.ttf", 40)
  
  audiotest_scene = scenes.create("audiotest")
  front_scene = scenes.create("front")
  
  game_structure = {audiotest = audiotest_scene.id,
                    front = front_scene.id}
    
  scenes.setCurrent(front_scene.id)
end

function love.update(dt)
  if scenes.current then
    scenes.getCurrent().update(dt)
  end
end

function love.keypressed( key, unicode )
  if scenes.current then
    scenes.getCurrent().keypressed( key, unicode )
  end
end

function love.keyreleased( key, unicode )
  if scenes.current then
    scenes.getCurrent().keyreleased( key, unicode )
  end
end


function love.draw()
  if scenes.current then
    scenes.getCurrent().draw()
  end
end
