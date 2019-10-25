buffs = {"polluting","hardened","irradiated","sharpened"}
polluting_tint = {r=0.96, g=0.1, b=0.1, a=0.87}
hardened_tint = {r=0.92, g=0.48, b=0.29, a=0.87}
irradiated_tint = {r=0.1, g=0.96, b=0.1, a=0.87}
sharpened_tint = {r=0.1, g=0.96, b=0.96, a=0.87}
smallbiterscale = 0.5
mediumbiterscale = 0.7
bigbiterscale = 1.0
behemothbiterscale = 1.2

--- BASE Biter Units
data:extend(
{
  {
    type = "unit",
    name = "small-biter-base",
    icon = "__base__/graphics/icons/small-biter.png",
    icon_size = 32,
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "not-repairable", "breaths-air"},
    max_health = 15,
    order = "b-b-a",
    subgroup="enemies",
    resistances = {},
    healing_per_tick = 0.01,
    collision_box = {{-0.2, -0.2}, {0.2, 0.2}},
    selection_box = {{-0.4, -0.7}, {0.7, 0.4}},
    attack_parameters =
    {
        type = "projectile",
        range = 0.5,
        cooldown = 35,
        ammo_type = make_unit_melee_ammo_type(7),
        sound = make_biter_roars(0.4),
        animation = biterattackanimation(small_biter_scale, small_biter_tint1, small_biter_tint2)
    },
    vision_distance = 30,
    movement_speed = 0.2,
    distance_per_frame = 0.125,
    pollution_to_join_attack = 4,
    distraction_cooldown = 300,
    min_pursue_time = 10 * 60,
    max_pursue_distance = 50,
    corpse = "small-biter-corpse",
    dying_explosion = "blood-explosion-small",
    dying_sound =  make_biter_dying_sounds(0.4),
    working_sound =  make_biter_calls(0.3),
    run_animation = biterrunanimation(small_biter_scale, small_biter_tint1, small_biter_tint2),
    ai_settings = biter_ai_settings
  },
  {
    type = "unit",
    name = "medium-biter-base",
    icon = "__base__/graphics/icons/medium-biter.png",
    icon_size = 32,
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
    max_health = 75,
    order="b-b-b",
    subgroup="enemies",
    resistances =
    {
      {
        type = "physical",
        decrease = 4,
        percent = 10
      },
      {
        type = "explosion",
        percent = 10
      }
    },
    healing_per_tick = 0.01,
    collision_box = {{-0.3, -0.3}, {0.3, 0.3}},
    selection_box = {{-0.7, -1.5}, {0.7, 0.3}},
    sticker_box = {{-0.3, -0.5}, {0.3, 0.1}},
    distraction_cooldown = 300,
    min_pursue_time = 10 * 60,
    max_pursue_distance = 50,
    attack_parameters =
    {
      type = "projectile",
      ammo_type = make_unit_melee_ammo_type(15),
      range = 1,
      cooldown = 35,
      sound = make_biter_roars(0.5),
      animation = biterattackanimation(medium_biter_scale, medium_biter_tint1, medium_biter_tint2)
    },
    vision_distance = 30,
    movement_speed = 0.24,
    distance_per_frame = 0.188,
    -- in pu
    pollution_to_join_attack = 20,
    corpse = "medium-biter-corpse",
    dying_explosion = "blood-explosion-small",
    working_sound = make_biter_calls(0.4),
    dying_sound = make_biter_dying_sounds(0.5),
    run_animation = biterrunanimation(medium_biter_scale, medium_biter_tint1, medium_biter_tint2),
    ai_settings = biter_ai_settings
  },
  {
    type = "unit",
    name = "big-biter-base",
    order="b-b-c",
    icon = "__base__/graphics/icons/big-biter.png",
    icon_size = 32,
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
    max_health = 375,
    subgroup="enemies",
    resistances =
    {
      {
        type = "physical",
        decrease = 8,
        percent = 10
      },
      {
        type = "explosion",
        percent = 10
      }
    },
    spawning_time_modifier = 3,
    healing_per_tick = 0.02,
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.7, -1.5}, {0.7, 0.3}},
    sticker_box = {{-0.6, -0.8}, {0.6, 0}},
    distraction_cooldown = 300,
    min_pursue_time = 10 * 60,
    max_pursue_distance = 50,
    attack_parameters =
    {
      type = "projectile",
      range = 1.5,
      cooldown = 35,
      ammo_type = make_unit_melee_ammo_type(30),
      sound =  make_biter_roars(0.6),
      animation = biterattackanimation(big_biter_scale, big_biter_tint1, big_biter_tint2)
    },
    vision_distance = 30,
    movement_speed = 0.23,
    distance_per_frame = 0.30,
    -- in pu
    pollution_to_join_attack = 80,
    corpse = "big-biter-corpse",
    dying_explosion = "blood-explosion-big",
    working_sound = make_biter_calls(0.5),
    dying_sound = make_biter_dying_sounds(0.6),
    run_animation = biterrunanimation(big_biter_scale, big_biter_tint1, big_biter_tint2),
    ai_settings = biter_ai_settings
  },
  {
    type = "unit",
    name = "behemoth-biter-base",
    order="b-b-d",
    icon = "__base__/graphics/icons/behemoth-biter.png",
    icon_size = 32,
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
    max_health = 3000,
    subgroup="enemies",
    resistances =
    {
      {
        type = "physical",
        decrease = 12,
        percent = 10
      },
      {
        type = "explosion",
        decrease = 12,
        percent = 10
      }
    },
    spawning_time_modifier = 12,
    healing_per_tick = 0.1,
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.7, -1.5}, {0.7, 0.3}},
    sticker_box = {{-0.6, -0.8}, {0.6, 0}},
    distraction_cooldown = 300,
    min_pursue_time = 10 * 60,
    max_pursue_distance = 50,
    attack_parameters =
    {
      type = "projectile",
      range = 1.5,
      cooldown = 50,
      ammo_type = make_unit_melee_ammo_type(90),
      sound =  make_biter_roars(0.8),
      animation = biterattackanimation(behemoth_biter_scale, behemoth_biter_tint1, behemoth_biter_tint2)
    },
    vision_distance = 30,
    movement_speed = 0.3,
    distance_per_frame = 0.32,
    -- in pu
    pollution_to_join_attack = 400,
    corpse = "behemoth-biter-corpse",
    dying_explosion = "blood-explosion-big",
    working_sound = make_biter_calls(0.7),
    dying_sound = make_biter_dying_sounds(0.8),
    run_animation = biterrunanimation(behemoth_biter_scale, behemoth_biter_tint1, behemoth_biter_tint2),
    ai_settings = biter_ai_settings
  }
})

------------------------------------------------------------------------------------------

local function generate_locale(buff, size)
    locale = {["name"] = "Biter", ["description"] = "Biter"}
   
    if(buff == "sharpened") then
        locale.name = size.."Sharpened "..locale.name
        locale.description = locale.description.." with very sharp claws"
    end
    if(buff == "irradiated") then
        locale.name = size.."Irradiated "..locale.name
        locale.description = locale.description.." with a strange glow"
    end
    if(buff == "hardened") then
        locale.name = size.."Hardened "..locale.name
        locale.description = locale.description.." with a hard exoskeleton"
    end
    if(buff == "polluting") then
        locale.name = size.."Polluting "..locale["name"]
        locale.description = "A Pyromaniac "..locale["description"]
    end
    return locale
end

local function get_buffed_attack_params(scale, base_params, buff)
    local params = base_params

    if(buff == "sharpened") then
        params.damage_modifier=2
        params.animation=biterattackanimation(scale, sharpened_tint, sharpened_tint)
    end
    if(buff == "irradiated") then
        params.animation=biterattackanimation(scale, irradiated_tint, irradiated_tint)
    end
    if(buff == "hardened") then
        params.animation=biterattackanimation(scale, hardened_tint, hardened_tint)
    end
    if(buff == "polluting") then
        params.animation=biterattackanimation(scale, polluting_tint, polluting_tint)
    end
    return params
end

local function buff_resistance(base_resistances, updates)
    local updated_buff_table = base_resistances
    for i, original_value in pairs(base_resistances) do
        for j, update_value in pairs(updates) do
            if updated_buff_table[i].type == update_value.type then
                updated_buff_table[i] = updates[j]
            end
        end
    end
    return updated_buff_table
end

local function get_buffed_resistances(base_resistances, buff)
    local resistances = {}
    if(buff == "hardened") then
        resistances = buff_resistance(base_resistances, {{type = "physical", percent = 98},{type = "explosive", percent = 2, decrease = 0}})
    end
    if(buff == "polluting") then
        -- resistances = buff_resistance(base_resistances, {{type = "fire", percent = 0},{type = "explosive", percent = 10}})
    end
    return resistances
end



local function get_run_animation(scale, buff)
    if(buff == "sharpened") then
        return biterrunanimation(scale, sharpened_tint, sharpened_tint)
    end 
    if(buff == "irradiated") then
        return biterrunanimation(scale, irradiated_tint, irradiated_tint)
    end
    if(buff == "hardened") then
        return biterrunanimation(scale, hardened_tint, hardened_tint)
    end
    if(buff == "polluting") then
        return biterrunanimation(scale, polluting_tint, polluting_tint)
    end
end



for _, buff in ipairs(buffs) do
    --small biters
    infused_biter_unit = table.deepcopy(data.raw.unit["small-biter-base"])
	infused_biter_unit.name = buff.."-small-biter"
    infused_biter_unit.resistances = get_buffed_resistances(infused_biter_unit["resistances"],buff)
    infused_biter_unit.attack_parameters = get_buffed_attack_params(smallbiterscale,infused_biter_unit.attack_parameters,buff)
    local locale = generate_locale(buff, "Small ")
    infused_biter_unit["localised_name"] = locale["name"]
    infused_biter_unit["localised_description"] = locale["description"]
    infused_biter_unit["run_animation"] = get_run_animation(smallbiterscale,buff);

    data:extend{infused_biter_unit}

    --medium biters
    infused_biter_unit = table.deepcopy(data.raw.unit["medium-biter-base"])
	infused_biter_unit.name = buff.."-medium-biter"
    infused_biter_unit.resistances = get_buffed_resistances(infused_biter_unit["resistances"],buff)
    infused_biter_unit.attack_parameters = get_buffed_attack_params(mediumbiterscale,infused_biter_unit.attack_parameters,buff)
    local locale = generate_locale(buff, "Medium ")
    infused_biter_unit["localised_name"] = locale["name"]
    infused_biter_unit["localised_description"] = locale["description"]
    infused_biter_unit["run_animation"] = get_run_animation(mediumbiterscale,buff);
    
    data:extend{infused_biter_unit}

    --big biters
    infused_biter_unit = table.deepcopy(data.raw.unit["big-biter-base"])
	infused_biter_unit.name = buff.."-big-biter"
    infused_biter_unit.resistances = get_buffed_resistances(infused_biter_unit["resistances"],buff)
    infused_biter_unit.attack_parameters = get_buffed_attack_params(bigbiterscale,infused_biter_unit.attack_parameters,buff)
    local locale = generate_locale(buff, "Big ")
    infused_biter_unit["localised_name"] = locale["name"]
    infused_biter_unit["localised_description"] = locale["description"]
    infused_biter_unit["run_animation"] = get_run_animation(bigbiterscale,buff);
    
    data:extend{infused_biter_unit}

    --Behemoth biters
    infused_biter_unit = table.deepcopy(data.raw.unit["behemoth-biter-base"])
	infused_biter_unit.name = buff.."-behemoth-biter"
    infused_biter_unit.resistances = get_buffed_resistances(infused_biter_unit["resistances"],buff)
    infused_biter_unit.attack_parameters = get_buffed_attack_params(behemothbiterscale,infused_biter_unit.attack_parameters,buff)
    local locale = generate_locale(buff, "Behemoth ")
    infused_biter_unit["localised_name"] = locale["name"]
    infused_biter_unit["localised_description"] = locale["description"]
    infused_biter_unit["run_animation"] = get_run_animation(behemothbiterscale,buff);
    
    data:extend{infused_biter_unit}
end