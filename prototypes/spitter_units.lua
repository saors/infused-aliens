buffs = {"polluting","hardened","irradiated","sharpened"}
polluting_tint = {r=0.96, g=0.1, b=0.1, a=0.87}
hardened_tint = {r=0.92, g=0.48, b=0.29, a=0.87}
irradiated_tint = {r=0.1, g=0.96, b=0.1, a=0.87}
sharpened_tint = {r=0.1, g=0.96, b=0.96, a=0.87}
smallspitterscale = 0.5
mediumspitterscale = 0.7
bigspitterscale = 1.0
behemothspitterscale = 1.2

function spitter_attack_parameters(data)
  return
  {
    type = "stream",
    ammo_category = "biological",
    cooldown = data.cooldown,
    range = data.range,
    min_attack_distance = data.min_attack_distance,
    --projectile_creation_distance = 1.9,
    damage_modifier = data.damage_modifier,
    warmup = 30,
    projectile_creation_parameters = spitter_shoot_shiftings(data.scale, data.scale * scale_spitter_stream),
    use_shooter_direction = true,

    lead_target_for_projectile_speed = 0.2* 0.75 * 1.5 *1.5, -- this is same as particle horizontal speed of flamethrower fire stream

    ammo_type =
    {
      category = "biological",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "stream",
          stream = data.acid_stream_name
        }
      }
    },
    sound = make_spitter_roars(data.roarvolume),
    animation = spitterattackanimation(data.scale, data.tint1, data.tint2)
  }
end

--- BASE Spitter Units
data:extend(
{
  {
    type = "unit",
    name = "small-spitter-base",
    icon = "__base__/graphics/icons/small-spitter.png",
    icon_size = 32,
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
    max_health = 10,
    order="b-b-e",
    subgroup="enemies",
    resistances = {},
    healing_per_tick = 0.01,
    collision_box = {{-0.3, -0.3}, {0.3, 0.3}},
    selection_box = {{-0.4, -0.4}, {0.4, 0.4}},
    sticker_box = {{-0.3, -0.5}, {0.3, 0.1}},
    distraction_cooldown = 300,
    min_pursue_time = 10 * 60,
    max_pursue_distance = 50,

    alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
    attack_parameters = spitter_attack_parameters(
    {
      acid_stream_name = "acid-stream-spitter-small",
      range=range_spitter_small,
      min_attack_distance=10,
      cooldown=100,
      damage_modifier=damage_modifier_spitter_small,
      scale=scale_spitter_small,
      tint1=tint_1_spitter_small,
      tint2=tint_2_spitter_small,
      roarvolume=0.4
    }),
    vision_distance = 30,
    movement_speed = 0.185,

    distance_per_frame = 0.04,
    -- in pu
    pollution_to_join_attack = 4,
    corpse = "small-spitter-corpse",
    dying_explosion = "blood-explosion-small",
    working_sound = make_biter_calls(0.3),
    dying_sound = make_spitter_dying_sounds(0.4),
    run_animation = spitterrunanimation(scale_spitter_small, tint_1_spitter_small, tint_2_spitter_small),
    ai_settings = biter_ai_settings
  },
  {
    type = "unit",
    name = "medium-spitter-base",
    icon = "__base__/graphics/icons/medium-spitter.png",
    icon_size = 32,
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
    max_health = 50,
    order="b-b-f",
    subgroup="enemies",
    resistances =
    {
      {
        type = "explosion",
        percent = 10
      }
    },
    healing_per_tick = 0.01,
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.5, -0.7}, {0.5, 0.7}},
    sticker_box = {{-0.3, -0.5}, {0.3, 0.1}},
    distraction_cooldown = 300,
    min_pursue_time = 10 * 60,
    max_pursue_distance = 50,
    alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
    attack_parameters = spitter_attack_parameters(
    {
      acid_stream_name = "acid-stream-spitter-medium",
      range=range_spitter_medium,
      min_attack_distance=10,
      cooldown=100,
      damage_modifier=damage_modifier_spitter_medium,
      scale=scale_spitter_medium,
      tint1=tint_1_spitter_medium,
      tint2=tint_2_spitter_medium,
      roarvolume=0.5
    }),
    vision_distance = 30,
    movement_speed = 0.165,
    distance_per_frame = 0.055,
    -- in pu
    pollution_to_join_attack = 12,
    corpse = "medium-spitter-corpse",
    dying_explosion = "blood-explosion-small",
    working_sound = make_biter_calls(0.4),
    dying_sound = make_spitter_dying_sounds(0.5),
    run_animation = spitterrunanimation(scale_spitter_medium, tint_1_spitter_medium, tint_2_spitter_medium),
    ai_settings = biter_ai_settings
  },
  {
    type = "unit",
    name = "big-spitter-base",
    icon = "__base__/graphics/icons/big-spitter.png",
    icon_size = 32,
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
    max_health = 200,
    order="b-b-g",
    subgroup="enemies",
    resistances =
    {
      {
        type = "explosion",
        percent = 15
      }
    },
    spawning_time_modifier = 3,
    healing_per_tick = 0.01,
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.7, -1.0}, {0.7, 1.0}},
    sticker_box = {{-0.3, -0.5}, {0.3, 0.1}},
    distraction_cooldown = 300,
    min_pursue_time = 10 * 60,
    max_pursue_distance = 50,
    alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
    attack_parameters = spitter_attack_parameters(
    {
      acid_stream_name = "acid-stream-spitter-big",
      range=range_spitter_big,
      min_attack_distance=10,
      cooldown=100,
      damage_modifier=damage_modifier_spitter_big,
      scale=scale_spitter_big,
      tint1=tint_1_spitter_big,
      tint2=tint_2_spitter_big,
      roarvolume=0.6
    }),
    vision_distance = 30,
    movement_speed = 0.15,
    distance_per_frame = 0.07,
    -- in pu
    pollution_to_join_attack = 30,
    corpse = "big-spitter-corpse",
    dying_explosion = "blood-explosion-big",
    working_sound = make_biter_calls(0.5),
    dying_sound = make_spitter_dying_sounds(0.6),
    run_animation = spitterrunanimation(scale_spitter_big, tint_1_spitter_big, tint_2_spitter_big),
    ai_settings = biter_ai_settings
  },
  {
    type = "unit",
    name = "behemoth-spitter-base",
    icon = "__base__/graphics/icons/behemoth-spitter.png",
    icon_size = 32,
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
    max_health = 1500,
    order="b-b-h",
    subgroup="enemies",
    resistances =
    {
      {
        type = "explosion",
        percent = 30
      }
    },
    spawning_time_modifier = 12,
    healing_per_tick = 0.1,
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    selection_box = {{-0.7, -1.0}, {0.7, 1.0}},
    sticker_box = {{-0.3, -0.5}, {0.3, 0.1}},
    distraction_cooldown = 300,
    min_pursue_time = 10 * 60,
    max_pursue_distance = 50,
    alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence,
    attack_parameters = spitter_attack_parameters(
    {
      acid_stream_name = "acid-stream-spitter-behemoth",
      range=range_spitter_behemoth,
      min_attack_distance=10,
      cooldown=100,
      damage_modifier=damage_modifier_spitter_behemoth,
      scale=scale_spitter_behemoth,
      tint1=tint_1_spitter_behemoth,
      tint2=tint_2_spitter_behemoth,
      roarvolume=0.8
    }),
    vision_distance = 30,
    movement_speed = 0.15,
    distance_per_frame = 0.084,
    pollution_to_join_attack = 200,
    corpse = "behemoth-spitter-corpse",
    dying_explosion = "blood-explosion-big",
    working_sound = make_biter_calls(0.7),
    dying_sound = make_spitter_dying_sounds(0.8),
    run_animation = spitterrunanimation(scale_spitter_behemoth, tint_1_spitter_behemoth, tint_2_spitter_behemoth),
    ai_settings = biter_ai_settings
  }
})

------------------------------------------------------------------------------------------

local function generate_locale(buff, size)
    locale = {["name"] = "Spitter", ["description"] = "Spitter"}
   
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
        params.animation=spitterattackanimation(scale, sharpened_tint, sharpened_tint)
    end
    if(buff == "irradiated") then
        params.animation=spitterattackanimation(scale, irradiated_tint, irradiated_tint)
    end
    if(buff == "hardened") then
        params.animation=spitterattackanimation(scale, hardened_tint, hardened_tint)
    end
    if(buff == "polluting") then
        params.animation=spitterattackanimation(scale, polluting_tint, polluting_tint)
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
        return spitterrunanimation(scale, sharpened_tint, sharpened_tint)
    end 
    if(buff == "irradiated") then
        return spitterrunanimation(scale, irradiated_tint, irradiated_tint)
    end
    if(buff == "hardened") then
        return spitterrunanimation(scale, hardened_tint, hardened_tint)
    end
    if(buff == "polluting") then
        return spitterrunanimation(scale, polluting_tint, polluting_tint)
    end
end



for _, buff in ipairs(buffs) do
  --small spitters
  infused_spitter_unit = table.deepcopy(data.raw.unit["small-spitter-base"])
  infused_spitter_unit.name = buff.."-small-spitter"
  infused_spitter_unit.resistances = get_buffed_resistances(infused_spitter_unit["resistances"],buff)
  infused_spitter_unit.attack_parameters = get_buffed_attack_params(smallspitterscale,infused_spitter_unit.attack_parameters,buff)
  local locale = generate_locale(buff, "Small ")
  infused_spitter_unit["localised_name"] = locale["name"]
  infused_spitter_unit["localised_description"] = locale["description"]
  infused_spitter_unit["run_animation"] = get_run_animation(smallspitterscale,buff);

  data:extend{infused_spitter_unit}

  --medium spitters
  infused_spitter_unit = table.deepcopy(data.raw.unit["medium-spitter-base"])
  infused_spitter_unit.name = buff.."-medium-spitter"
  infused_spitter_unit.resistances = get_buffed_resistances(infused_spitter_unit["resistances"],buff)
  infused_spitter_unit.attack_parameters = get_buffed_attack_params(mediumspitterscale,infused_spitter_unit.attack_parameters,buff)
  local locale = generate_locale(buff, "Medium ")
  infused_spitter_unit["localised_name"] = locale["name"]
  infused_spitter_unit["localised_description"] = locale["description"]
  infused_spitter_unit["run_animation"] = get_run_animation(mediumspitterscale,buff);
  
  data:extend{infused_spitter_unit}

  --big spitters
  infused_spitter_unit = table.deepcopy(data.raw.unit["big-spitter-base"])
  infused_spitter_unit.name = buff.."-big-spitter"
  infused_spitter_unit.resistances = get_buffed_resistances(infused_spitter_unit["resistances"],buff)
  infused_spitter_unit.attack_parameters = get_buffed_attack_params(bigspitterscale,infused_spitter_unit.attack_parameters,buff)
  local locale = generate_locale(buff, "Big ")
  infused_spitter_unit["localised_name"] = locale["name"]
  infused_spitter_unit["localised_description"] = locale["description"]
  infused_spitter_unit["run_animation"] = get_run_animation(bigspitterscale,buff);
  
  data:extend{infused_spitter_unit}

  --Behemoth spitters
  infused_spitter_unit = table.deepcopy(data.raw.unit["behemoth-spitter-base"])
  infused_spitter_unit.name = buff.."-behemoth-spitter"
  infused_spitter_unit.resistances = get_buffed_resistances(infused_spitter_unit["resistances"],buff)
  infused_spitter_unit.attack_parameters = get_buffed_attack_params(behemothspitterscale,infused_spitter_unit.attack_parameters,buff)
  local locale = generate_locale(buff, "Behemoth ")
  infused_spitter_unit["localised_name"] = locale["name"]
  infused_spitter_unit["localised_description"] = locale["description"]
  infused_spitter_unit["run_animation"] = get_run_animation(behemothspitterscale,buff);
  
  data:extend{infused_spitter_unit}
end