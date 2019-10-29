entitiesToBeGenerated={}

buff_matrix={
  "polluting",
  "polluting_hardened",
  "polluting_radioactive",
  "polluting_sharpened",
  "polluting_hardened_radioactive",
  "polluting_radioactive_sharpened",
  "polluting_hardened_sharpened",
  "polluting_hardened_radioactive_sharpened",
  "hardened",
  "hardened_radioactive",
  "hardened_sharpened",
  "hardened_radioactive_sharpened",
  "radioactive",
  "radioactive_sharpened",
  "sharpened",
}

data:extend(
{
  {
    type = "unit-spawner",
    name = "spitter-spawner-base",
    icon = "__base__/graphics/icons/biter-spawner.png",
    icon_size = 32,
    flags = {"placeable-player", "placeable-enemy", "not-repairable"},
    max_health = 350,
    order="b-b-h",
    subgroup="enemies",
    working_sound =
    {
      sound =
      {
        {
          filename = "__base__/sound/creatures/spawner.ogg",
          volume = 1.0
        }
      },
      apparent_volume = 2
    },
    dying_sound =
    {
      {
        filename = "__base__/sound/creatures/spawner-death-1.ogg",
        volume = 1.0
      },
      {
        filename = "__base__/sound/creatures/spawner-death-2.ogg",
        volume = 1.0
      }
    },
    resistances =
    {
      {
        type = "physical",
        decrease = 2,
        percent = 15
      },
      {
        type = "explosion",
        decrease = 5,
        percent = 15
      },
      {
        type = "fire",
        decrease = 3,
        percent = 60
      }
    },
    healing_per_tick = 0.02,
    collision_box = {{-3.2, -2.2}, {2.2, 2.2}},
    map_generator_bounding_box = {{-4.2, -3.2}, {3.2, 3.2}},
    selection_box = {{-3.5, -2.5}, {2.5, 2.5}},
    pollution_absorption_absolute = 20,
    pollution_absorption_proportional = 0.01,
    corpse = "spitter-spawner-corpse",
    dying_explosion = "blood-explosion-huge",
    max_count_of_owned_units = 7,
    max_friends_around_to_spawn = 5,
    animations =
    {
      spawner_idle_animation(0, spitter_spawner_tint),
      spawner_idle_animation(1, spitter_spawner_tint),
      spawner_idle_animation(2, spitter_spawner_tint),
      spawner_idle_animation(3, spitter_spawner_tint)
    },
    integration = spawner_integration(),
    result_units = (function()
                     local res = {}
                     res[1] = {"small-biter", {{0.0, 0.3}, {0.35, 0}}}
                     res[2] = {"small-spitter", {{0.25, 0.0}, {0.5, 0.3}, {0.7, 0.0}}}
                     res[3] = {"medium-spitter", {{0.4, 0.0}, {0.7, 0.3}, {0.9, 0.1}}}
                     res[4] = {"big-spitter", {{0.5, 0.0}, {1.0, 0.4}}}
                     res[5] = {"behemoth-spitter", {{0.9, 0.0}, {1.0, 0.3}}}
                     return res
                   end)(),
    -- With zero evolution the spawn rate is 6 seconds, with max evolution it is 2.5 seconds
    spawning_cooldown = {360, 150},
    spawning_radius = 10,
    spawning_spacing = 3,
    max_spawn_shift = 0,
    max_richness_for_spawn_shift = 100,
    -- distance_factor used to be 1, but Twinsen says:
    -- "The number or spitter spwners should be roughly equal to the number of biter spawners(regardless of difficulty)."
    -- (2018-12-07)
    autoplace =nil,
    call_for_help_radius = 50
  }
})

local function determine_spawner_resistances(buffs)

  resistances = {
    {
      type = "physical",
      decrease = 2,
      percent = 15
    },
    {
      type = "explosion",
      decrease = 5,
      percent = 15
    },
    {
      type = "fire",
      decrease = 3,
      percent = 60
    }
  }
  for _, value in ipairs(buffs) do 
    if(value == "polluting") then
      resistances[3].percent = 0
    end
    if(value == "hardened") then
      resistances[1].percent = 98
    end
    if(value == "radioactive") then
    end
    if(value == "sharpened") then
    end
  end
  return resistances
end

local function setSpawnerUnits(buffs)
  local units = {}
  for _, value in pairs(buffs) do
    if(value == "sharpened") then
      table.insert( units, {"sharpened-small-spitter", {{0.0, 0.3}, {0.6, 0.0}}} )
      table.insert( units, {"sharpened-medium-spitter", {{0.2, 0.0}, {0.6, 0.3}, {0.7, 0.1}}} )
      table.insert( units, {"sharpened-big-spitter", {{0.5, 0.0}, {1.0, 0.4}}} )
      table.insert( units, {"sharpened-behemoth-spitter", {{0.9, 0.0}, {1.0, 0.3}}}) 
    end
    if(value == "radioactive") then
      table.insert( units, {"radioactive-small-spitter", {{0.0, 0.3}, {0.6, 0.0}}} )
      table.insert( units, {"radioactive-medium-spitter", {{0.2, 0.0}, {0.6, 0.3}, {0.7, 0.1}}})
      table.insert( units, {"radioactive-big-spitter", {{0.5, 0.0}, {1.0, 0.4}}} )
      table.insert( units, {"radioactive-behemoth-spitter", {{0.9, 0.0}, {1.0, 0.3}}} )
    end
    if(value == "hardened") then
      table.insert( units, {"hardened-small-spitter", {{0.0, 0.3}, {0.6, 0.0}}} )
      table.insert( units, {"hardened-medium-spitter", {{0.2, 0.0}, {0.6, 0.3}, {0.7, 0.1}}})
      table.insert( units, {"hardened-big-spitter", {{0.5, 0.0}, {1.0, 0.4}}} )
      table.insert( units, {"hardened-behemoth-spitter", {{0.9, 0.0}, {1.0, 0.3}}} )
    end
    if(value == "polluting") then
      table.insert( units, {"polluting-small-spitter", {{0.0, 0.3}, {0.6, 0.0}}} )
      table.insert( units, {"polluting-medium-spitter", {{0.2, 0.0}, {0.6, 0.3}, {0.7, 0.1}}})
      table.insert( units, {"polluting-big-spitter", {{0.5, 0.0}, {1.0, 0.4}}} )
      table.insert( units, {"polluting-behemoth-spitter", {{0.9, 0.0}, {1.0, 0.3}}} )
    end
  end
  return units
end

local function generateLocale(buffs)
  locale = {["name"] = "Spitter Spawner", ["description"] = "Spitter Spawner that will spawn"}
  for _, value in ipairs(buffs) do
    if(value == "sharpened") then
      locale.name = "Sharpened "..locale.name
      locale.description = locale.description.." sharpened"
    end
    if(value == "radioactive") then
      locale.name = "Radioactive "..locale.name
      locale.description = locale.description.." iradiated"
    end
    if(value == "hardened") then
      locale.name = "Hardened "..locale.name
      locale.description = locale.description.." polluting"
    end
    if(value == "polluting") then
      locale.name = "Polluting "..locale.name
      locale.description = locale.description.." polluting"
    end
  end
  locale.description = locale.description.." spitters"
  return locale
end

local function convertToBuffList(buff_string)
  buffs = {}
  for w in buff_string:gmatch("([^_]+)") do --regex to split on underscore
    table.insert( buffs, w )
  end
  return buffs
end

for _,type in pairs(buff_matrix) do
  spawnerBase = table.deepcopy(data.raw["unit-spawner"]["spitter-spawner-base"])
  spawnerBase["name"] = type.."_spitter_spawner"
  local buffs = convertToBuffList(type)
  local localeMessage = generateLocale(buffs)
  spawnerBase["resistances"] = determine_spawner_resistances(buffs)
  spawnerBase["localised_name"] = localeMessage["name"]
  spawnerBase["localised_description"] = localeMessage["description"]
  spawnerBase.result_units = setSpawnerUnits(buffs)
  data:extend{spawnerBase}
end

