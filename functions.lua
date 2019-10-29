infused_aliens_functions = {}

infused_aliens_functions.copy = function
  local infusion_buffs = {

    locale = {
        name_modifier = "sharp",
        update_description = true
    },
  
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
    },

    units = {
      {"sharpened-small-biter", {{0.0, 0.3}, {0.6, 0.0}}}
    }
  }
  return infusion_buffs
end


infused_spawners.infusion = function(buff_table)

return updates
end


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
      table.insert( units, {"sharpened-small-biter", {{0.0, 0.3}, {0.6, 0.0}}} )
      table.insert( units, {"sharpened-medium-biter", {{0.2, 0.0}, {0.6, 0.3}, {0.7, 0.1}}} )
      table.insert( units, {"sharpened-big-biter", {{0.5, 0.0}, {1.0, 0.4}}} )
      table.insert( units, {"sharpened-behemoth-biter", {{0.9, 0.0}, {1.0, 0.3}}}) 
    end
    if(value == "radioactive") then
      table.insert( units, {"radioactive-small-biter", {{0.0, 0.3}, {0.6, 0.0}}} )
      table.insert( units, {"radioactive-medium-biter", {{0.2, 0.0}, {0.6, 0.3}, {0.7, 0.1}}})
      table.insert( units, {"radioactive-big-biter", {{0.5, 0.0}, {1.0, 0.4}}} )
      table.insert( units, {"radioactive-behemoth-biter", {{0.9, 0.0}, {1.0, 0.3}}} )
    end
    if(value == "hardened") then
      table.insert( units, {"hardened-small-biter", {{0.0, 0.3}, {0.6, 0.0}}} )
      table.insert( units, {"hardened-medium-biter", {{0.2, 0.0}, {0.6, 0.3}, {0.7, 0.1}}})
      table.insert( units, {"hardened-big-biter", {{0.5, 0.0}, {1.0, 0.4}}} )
      table.insert( units, {"hardened-behemoth-biter", {{0.9, 0.0}, {1.0, 0.3}}} )
    end
    if(value == "polluting") then
      table.insert( units, {"polluting-small-biter", {{0.0, 0.3}, {0.6, 0.0}}} )
      table.insert( units, {"polluting-medium-biter", {{0.2, 0.0}, {0.6, 0.3}, {0.7, 0.1}}})
      table.insert( units, {"polluting-big-biter", {{0.5, 0.0}, {1.0, 0.4}}} )
      table.insert( units, {"polluting-behemoth-biter", {{0.9, 0.0}, {1.0, 0.3}}} )
    end
  end
  return units
end

local function generateLocale(buffs)
  locale = {["name"] = "Biter Spawner", ["description"] = "Biter Spawner that will spawn"}
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
  locale.description = locale.description.." biters"
  return locale
end