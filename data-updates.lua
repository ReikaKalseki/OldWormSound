require "__DragonIndustries__/strings"

local prefix = "__OldWormSound__/sounds/roars/worm-roar-"
local pitches = {"high", "med", "low"}
local sounds = {"long-1", "short-1", "short-2", "short-3"}

local function make_old_worm_roars(volume, pitch)
  local ret = {}
  for _,sound in pairs(sounds) do
	local str = prefix .. sound .. "-" .. pitches[pitch] .. ".ogg"
	
	if true then
		str = "__OldWormSound__/sounds/attack/worm-spit-start-" .. (#ret+1) .. ".ogg"
	end
	
	ret[#ret+1] =
	{
		filename = str,
		volume = volume
	}
  end
  return
  {
    variations = ret,
    audible_distance_modifier = 1.5
  }
end

local function updateSound(worm)
	if not worm.attack_parameters.cyclic_sound then
		log(worm.name .. " had no cyclic sound to replace.")
		return
	end
	log("Modifying cycling sound of " .. worm.name)
	--[[
	local sounds = worm.attack_parameters.cyclic_sound.begin_sound
	for _,entry in pairs(sounds) do
		entry.filename = literalReplace(entry.filename, "__base__/sound/creatures", "__OldWormSound__/sounds/attack")
	end
	sounds = worm.attack_parameters.cyclic_sound.end_sound
	for _,entry in pairs(sounds) do
		entry.filename = literalReplace(entry.filename, "__base__/sound/creatures", "__OldWormSound__/sounds/attack")
	end
	--]]
	worm.attack_parameters.cyclic_sound.begin_sound =
        {
          {
            filename = "__OldWormSound__/sounds/attack/worm-spit-start-1.ogg",
            volume = 0.0
          },
          {
            filename = "__OldWormSound__/sounds/attack/worm-spit-start-2.ogg",
            volume = 0.0
          },
          {
            filename = "__OldWormSound__/sounds/attack/worm-spit-start-3.ogg",
            volume = 0.0
          },
          {
            filename = "__OldWormSound__/sounds/attack/worm-spit-start-4.ogg",
            volume = 0.0
          }
        }
	worm.attack_parameters.cyclic_sound.end_sound =
        {
          {
            filename = "__OldWormSound__/sounds/attack/worm-spit-end-1.ogg",
            volume = 0.0
          },
          {
            filename = "__OldWormSound__/sounds/attack/worm-spit-end-2.ogg",
            volume = 0.0
          }
        }
end

data.raw["turret"]["small-worm-turret"].starting_attack_sound = make_old_worm_roars(0.625, 1) --was 0.75 in base
data.raw["turret"]["medium-worm-turret"].starting_attack_sound = make_old_worm_roars(0.8, 2) --was 0.8 in base
data.raw["turret"]["big-worm-turret"].starting_attack_sound = make_old_worm_roars(1.0, 3) --was 0.95 in base

updateSound(data.raw["turret"]["small-worm-turret"])
updateSound(data.raw["turret"]["medium-worm-turret"])
updateSound(data.raw["turret"]["big-worm-turret"])

if data.raw["turret"]["behemoth-worm-turret"] then
	data.raw["turret"]["behemoth-worm-turret"].starting_attack_sound = make_old_worm_roars(1.0, 3)
end
