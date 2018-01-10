scenes = {}
scenes.objects = {}
scenes.luapath = "scenes/"
scenes.current = nil

local sceneregister = {}
local id = 1

function scenes:setup()
  sceneregister["audiotest"] = scenes.findscene("audiotest")
  sceneregister["front"] = scenes.findscene("front")
end

function scenes.findscene(scenename)
  return love.filesystem.load(scenes.luapath .. scenename .. ".lua")
end

function scenes.loadscene(scenename)
  scenemodule = scenes.findscene(scenename)
  return scenemodule()
end

function scenes.create(name)
  if sceneregister[name] then
    id = id + 1
    local scene = sceneregister[name]()
    scene.load()
    scene.pause()
    scene.id = id
    scenes.objects[id] = scene
    return scenes.objects[id]
  else
    return false
  end
end

function scenes.setCurrent(scene_id)
  for k,v in pairs(scenes.objects)
  do
    print(k,v)
  end
  
  print("Trying " .. scene_id)
  if scenes.objects[scene_id] then
    print("yes")
    scenes.current = scene_id
    scenes.objects[scene_id]:unpause()
  end
end

function scenes.getCurrent()
  return scenes.objects[scenes.current]
end

