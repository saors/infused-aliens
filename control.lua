infused_aliens_dictionary = {
    ["iron-ore"] = "sharpened",
    ["copper-ore"] = "sharpened",
    ["coal"] = "polluting",
    ["crude-oil"] = "polluting",
    ["uranium-ore"] = "radioactive",
    ["stone"] = "hardened"
}

infused_aliens_replaces = {
    ['biter-spawner']=true,
    ['spitter-spawner']=true
}

-- local function check_spawner_type_exists(type)
--   local prototype_spawners = game.get_filtered_entity_prototypes{ {filter="type", type="unit-spawner"} }
--   for _, spawner in pairs(prototype_spawners) do
--     if string.find(spawner.name, type) then
--       return true
--     end
--   end
--   return false
-- end

local function replace_vanilla_spawner(spawner, buff_string)
  local oldSpawner=spawner
  local oldSpawnerName=oldSpawner.name
  local spawner_type=""
  if oldSpawnerName == "biter-spawner" then
    spawner_type="biter-spawner"
  elseif oldSpawnerName == "spitter-spawner" then
    spawner_type="spitter-spawner"
  end
  local position=oldSpawner.position
  local surface=oldSpawner.surface
  local force=oldSpawner.force
  local newName=buff_string.."-"..spawner_type
  oldSpawner.destroy()   
  local newSpawner=surface.create_entity({name=newName, position=position, force=force})
end

local function get_buffs(ores)
  buffs = {["polluting"] = false, ["hardened"] = false,["radioactive"] = false, ["sharpened"] = false}
  for _,ore in pairs(ores) do
    if(ore.name == "iron-ore" or ore.name == "copper-ore") then
      buffs["sharpened"] = true
    elseif(ore.name == "stone") then
      buffs["hardened"] = true
    elseif(ore.name == "uranium-ore") then
      buffs["radioactive"] = true
    elseif(ore.name == "crude-oil" or ore.name == "coal") then
      buffs["polluting"] = true
    end
  end
  return buffs
end

local function create_buff_string(buffs)
  local buff_array = {}
  for key, buff in pairs(buffs) do
    table.insert(buff_array, key)
  end
  buff_string = ""
  table.sort(buff_array)
  for _, buff in pairs(buff_array) do
    if buffs[buff] then
      if(string.len(buff_string) < 1) then
        buff_string = buff
      else
        buff_string = buff_string.."-"..buff
      end
    end
  end
  return buff_string
end

local function set_biter_spawner_type(spawner, ores) --TODO rename and abstract
  local buffs = get_buffs(ores)
  local has_buff = false
  for key, buff in pairs(buffs) do 
    if buff == true then
      has_buff = true
    end
  end
  if has_buff then
    local buff_string = create_buff_string(buffs)
    replace_vanilla_spawner(spawner, buff_string)
  end
end

local function isTableEmpty(t)
  if t == nil then
    return true
  elseif t[1] == nil then
    return true
  else
    return false
  end
end

local function get_overlapping_ores(entity)
  local surface=entity.surface
  local bounding_box=entity.bounding_box
  overlapping_ores = {}
  matchedResources = surface.find_entities_filtered{area=bounding_box,type="resource"}
  if isTableEmpty(matchedResources) == false then
    for key, value in pairs(matchedResources) do --value may be array
      table.insert(overlapping_ores, value)
    end
  end
  return overlapping_ores
end

local function release_radiation(ent, scale)
  local raditon = "fire-radiation"
  local surface=ent.surface
  for ly=-scale, scale do
    for lx=-scale, scale do
      if surface.get_tile(ent.position.x+lx, ent.position.y+ly).collides_with("ground-tile") then
        ent.surface.create_entity{name=raditon, position={x=ent.position.x+lx, y=ent.position.y+ly}, ent.force}
      end
    end
  end
end

local function release_pollution(ent, amount)
  local source = ent.position
  ent.surface.pollute(source, amount)
end

local function check_chunk_for_spawners(area, surface)
  return surface.find_entities_filtered{area=area,name={"spitter-spawner", "biter-spawner"}}
end

script.on_event(defines.events.on_entity_spawned, function(event)
  local ent=event.entity
  if string.find(ent.name, "polluting") then
    if string.find(ent.name, "small") then
      release_pollution(ent, 50)
    elseif string.find(ent.name, "medium") then
      release_pollution(ent, 250)
    elseif string.find(ent.name, "big") then
      release_pollution(ent, 500)
    elseif string.find(ent.name, "behemoth") then
      release_pollution(ent, 5000)
    elseif string.find(ent.name, "spawner") then
      release_pollution(ent, 2000)
    end
  end
end)

script.on_event(defines.events.on_entity_died, function(event)
  local ent = event.entity
  if string.find(ent.name, "radioactive") then
    if string.find(ent.name, "small") then
      release_radiation(ent, 1)
    elseif string.find(ent.name, "medium") then
      release_radiation(ent, 2)
    elseif string.find(ent.name, "big") then
      release_radiation(ent, 4)
    elseif string.find(ent.name, "behemoth") then
      release_radiation(ent, 6)
    elseif string.find(ent.name, "spawner") then
      release_radiation(ent, 6)
    end
  end
  if string.find(ent.name, "polluting") then
    if string.find(ent.name, "small") then
      release_pollution(ent, 50)
    elseif string.find(ent.name, "medium") then
      release_pollution(ent, 250)
    elseif string.find(ent.name, "big") then
      release_pollution(ent, 500)
    elseif string.find(ent.name, "behemoth") then
      release_pollution(ent, 5000)
    elseif string.find(ent.name, "spawner") then
      release_pollution(ent, 2000)
    end
  end
end)

script.on_event(defines.events.on_biter_base_built, function(event)
  local entity=event.entity
  if infused_aliens_replaces[entity.name] then
    local overlapping_ores = get_overlapping_ores(entity);
    if isTableEmpty(overlapping_ores) == false then
      set_biter_spawner_type(entity, overlapping_ores)
    end
  end
end)

script.on_event(defines.events.on_chunk_generated, function(event)
  bases = check_chunk_for_spawners(event.area, event.surface) 
  for key, base in pairs(bases) do
    if infused_aliens_replaces[base.name] then
      local overlapping_ores = get_overlapping_ores(base);
      if isTableEmpty(overlapping_ores) == false then
        set_biter_spawner_type(base, overlapping_ores)
      end
    end
  end
end)

script.on_configuration_changed(on_configuration_changed)
script.on_init(on_init)
