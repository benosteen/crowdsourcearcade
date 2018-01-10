local audiotestScene = scenes.loadscene("scene")

function audiotestScene.load()
  
  musicfiles = {"music/slowpiano.ogg",
           "music/piano_light.ogg",
           "music/short_piano.ogg",
           "music/disco_style.ogg",
           "music/march.ogg",
           "music/upbeat.ogg"}
  
  musics = {}
  for i, fn in ipairs(musicfiles)
  do
    table.insert(musics, love.audio.newSource(fn, "stream", true))
    musics[i]:setVolume(0.5)
    musics[i]:setLooping(true)
  end
  
  basemusic = 1
  
  sfx = {Accept = love.audio.newSource("audio/accept.wav"), 
         LoadImage = love.audio.newSource("audio/loadimage.wav"),
         Change = love.audio.newSource("audio/change.wav"),
         Changev2 = love.audio.newSource("audio/change2.wav"),
         PewPew = love.audio.newSource("audio/pewblast.wav")}
  -- link to number keys
  names, sources, pressed = {}, {}, {}
  for n,src in pairs(sfx)
  do
    table.insert(names, n)
    table.insert(sources, src)
  end
end

function audiotestScene.pause()
  for _,src in pairs(sources)
  do
    if src:isPlaying() then
      love.audio.pause(src)
    end
  end
  
  love.audio.stop(musics[basemusic])
end

function audiotestScene.unpause()
    for _,src in pairs(sources)
  do
    if src:isPaused() then
      love.audio.play(src)
    end
  end
  
  love.audio.play(musics[basemusic])
end


function audiotestScene.update(dt)
  
end

function audiotestScene.keypressed( key, unicode )
    local a = tonumber(key)
    if sources[a] ~= nil then
      love.audio.play(sources[a])
      pressed[a] = true
    elseif key == "m" then
      love.audio.stop(musics[basemusic])
      basemusic = basemusic + 1
      if musics[basemusic] == nil then
        basemusic = 1
      end
      love.audio.play(musics[basemusic])
    elseif key == "escape" then
      -- go back to the front screen
      audiotestScene.pause()
      scenes.setCurrent(game_structure["front"])
    end
end

function audiotestScene.keyreleased( key, unicode )
    local a = tonumber(key)
    if sources[a] ~= nil then
      love.audio.stop(sources[a])
      pressed[a] = false
    end
end


function audiotestScene.draw()
  -- audio clips
  love.graphics.setBackgroundColor(22,28,22)
  love.graphics.setColor(255,0,0)
  for i,name in ipairs(names)
  do
    if pressed[i] then
      love.graphics.setFont(lrgfont)
      love.graphics.print(string.format("%d    %s !!", i, name), 50, 40 + 70 * (i-1))
      love.graphics.setFont(regularfont)
    else
      love.graphics.print(string.format("%d    %s", i, name), 50, 40 + 70 * (i-1))
    end
  end
  -- music
  love.graphics.setColor(255,255,255)
  love.graphics.setFont(smfont)
  love.graphics.print(string.format("Now playing  %s !%d!", musicfiles[basemusic], musics[basemusic]:tell()), 50, love.graphics.getHeight() - 50)
  love.graphics.print("Press ESC to go back", 300, 5)
  love.graphics.setFont(regularfont)
end


function audiotestScene.quit()
  for _,src in pairs(sources)
  do
    if src:isPlaying() then
      love.audio.stop(src)
    end
  end
  for _, ms in pairs(musics)
  do
    if ms.isPlaying() then
      love.audio.stop(ms)
    end
  end
end

return audiotestScene