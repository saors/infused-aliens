local all_buff_keys = {"hardened", "polluting", "radioactive", "sharpened"}

--templates
local hardened_template = base_template
local sharpened_template = base_template
local radioactive_template = base_template
local polluting_template = base_template

--colors
local polluting_tint = {r=0.96, g=0.1, b=0.1, a=0.87}
local hardened_tint = {r=0.92, g=0.48, b=0.29, a=0.87}
local radioactive_tint = {r=0.1, g=0.96, b=0.1, a=0.87}
local sharpened_tint = {r=0.1, g=0.96, b=0.96, a=0.87}

--scales
local smallunitscale = 0.5
local mediumunitscale = 0.7
local bigunitscale = 1.0
local behemothunitscale = 1.2

local vanilla_units = {
  "small-biter", 
  "small-spitter",
  "medium-biter",
  "medium-spitter", 
  "big-spitter", 
  "big-biter",
  "behemoth-biter", 
  "behemoth-spitter",
}

local vanilla_spawners = {
  "spitter-spawner",
  "biter-spawner"
}

local templates = {}

local function spitter_attack_parameters(data)
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

table.sort(all_buff_keys)

local function set_unit_color(unit, template, color)
  local scale = smallunitscale
  local spitter_range = range_spitter_small
  local spitter_dmg_modifier = damage_modifier_spitter_small
  local spitter_acid_stream_name = "acid-stream-spitter-small"
  local scale_factor = 1
  if string.find(unit, "medium") then
    scale = mediumunitscale
    spitter_range = range_spitter_medium
    spitter_dmg_modifier = damage_modifier_spitter_medium
    spitter_acid_stream_name = "acid-stream-spitter-medium"
    scale_factor = 2
  end
  if string.find(unit, "big") then
    scale = bigunitscale
    spitter_range = range_spitter_big
    spitter_dmg_modifier = damage_modifier_spitter_big
    spitter_acid_stream_name = "acid-stream-spitter-big"
    scale_factor = 3
  end
  if string.find(unit, "behemoth") then
    scale = behemothunitscale
    spitter_range = range_spitter_behemoth
    spitter_dmg_modifier = damage_modifier_spitter_behemoth
    spitter_acid_stream_name = "acid-stream-spitter-behemoth"
    scale_factor = 4
  end

  if(not template["attack_parameters"]) then
    template["attack_parameters"] = {}
  end
  if(not template["attack_parameters"][unit]) then
    template["attack_parameters"][unit] = {}
  end
  if(not template["run_animation"]) then
    template["run_animation"] = {}
  end
  if(not template["run_animation"][unit]) then
    template["run_animation"][unit] = {}
  end

  if string.find(unit, "biter") then
    local attack_params = {
      type = "projectile",
      range = 0.5 * scale_factor,
      cooldown = 35,
      ammo_type = make_unit_melee_ammo_type(7),
      sound = make_biter_roars(0.4 * scale_factor),
      animation = biterattackanimation(scale, color, color)
    }
    table.insert(template["attack_parameters"][unit], attack_params)
    template["run_animation"][unit] = biterrunanimation(scale, color, color)
  end
  if string.find(unit, "spitter") then
    local attack_params = spitter_attack_parameters({
      acid_stream_name = spitter_acid_stream_name,
      range=spitter_range,
      min_attack_distance=10,
      cooldown=100,
      damage_modifier=spitter_dmg_modifier,
      scale=scale,
      tint1=color,
      tint2=color,
      roarvolume=0.4 * scale_factor
    })
    table.insert(template["attack_parameters"][unit], attack_params)
    template["run_animation"][unit] = spitterrunanimation(scale, color, color)
  end
end

local function set_spawner_color(unit, template, color)
  if(not template["animations"]) then
    template["animations"] = {}
  end

  template["animations"][unit] = {
    spawner_idle_animation(0, color),
    spawner_idle_animation(1, color),
    spawner_idle_animation(2, color),
    spawner_idle_animation(3, color)
  }
end

local function turn_off_autoplace(spawner, template)
  if(not template["autoplace"]) then
    template["autoplace"] = {}
  end
  template["autoplace"][spawner] = "nil"
end


local function apply_custom_attributes(key, buff)
  local tint = sharpened_tint
  if(buff == "hardened") then
    tint = hardened_tint
    templates[key]["buff_value"]["modifications"]["resistances"] = {} --init resistances table
    for k,unit in pairs(vanilla_units) do
      templates[key]["buff_value"]["modifications"]["resistances"][unit] = {
        {
          type = "physical",
          decrease = 0,
          percent = (50 + (10 * math.ceil(k/2))) --(small = 1, med = 2, etc)*10 + 50
        },
        {
          type = "electric",
          decrease = 0,
          percent = (50 + (10 * math.ceil(k/2)))
        }
      }
    end
  end
  if(buff == "sharpened") then
    tint = sharpened_tint
    templates[key]["buff_value"]["modifications"]["attack_parameters"] = {}
    for k,unit in pairs(vanilla_units) do
      dmg_mod = 1.25 * (math.ceil(k/2)) --12 is base dmg mod for vanilla units, this makes the dmg mod 25% stronger
      templates[key]["buff_value"]["modifications"]["attack_parameters"][unit] = {}
      templates[key]["buff_value"]["modifications"]["attack_parameters"][unit]["damage_modifier"] = {}
      templates[key]["buff_value"]["modifications"]["attack_parameters"][unit]["damage_modifier"]= dmg_mod
    end
  end
  if(buff == "polluting") then
    tint = polluting_tint
  end
  if(buff == "radioactive") then
    tint = radioactive_tint
  end

  for _,unit in pairs(vanilla_units) do
    set_unit_color(unit, templates[key]["buff_value"]["modifications"], tint)
  end
  for _,spawner in pairs(vanilla_spawners) do
    set_spawner_color(spawner, templates[key]["buff_value"]["modifications"], tint)
  end
  for _,spawner in pairs(vanilla_spawners) do
    turn_off_autoplace(spawner, templates[key]["buff_value"]["modifications"])
  end
end

for key,buff in pairs(all_buff_keys) do
  templates[key] = infused_aliens_functions.get_template()
  templates[key]["buff_value"]["entities"] = infused_aliens_functions.get_vanilla_units()
  templates[key]["buff_key"] = buff
  apply_custom_attributes(key, buff)
end

for key,template in pairs(templates) do
  infused_aliens_functions.add_to_entries(template)
end

infused_aliens_functions.stage_entries()