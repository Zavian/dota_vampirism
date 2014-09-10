function SummonedGhoul(keys)
	local spawner = keys.caster
	local level = spawner:GetLevel()
	local spawnedGhoul = keys.target
	local spellNumber = math.random(1, 4)
	local spellToAdd = {}

	--Here I'll give to the summoned ghoul a random spell
	--I'm using an array just for simplcity of the code
	if(spellNumber == 1) then
		spellToAdd = { "ghoul_unholy_aura" }
	elseif(spellNumber == 2) then
		spellToAdd = { "ghoul_damage_aura" }
	elseif(spellNumber == 3) then
		spellToAdd = { "ghoul_mov_speed_aura", "ghoul_atk_speed_aura" }
	elseif(spellNumber == 4) then
		spellToAdd = { "ghoul_armor_aura" }
	end
	for i=1, table.getn(spellToAdd) do
		spawnedGhoul:AddAbility(spellToAdd[i])
		spawnedGhoul:FindAbilityByName(spellToAdd[i]):SetLevel(level)
	end	
end

function ShadowSightCasted(keys)
	local spawnedUnit = keys.target
	local ability = keys.ability
	local level = ability:GetLevel()
	local toSummon = ""
	if(level == 1) then 
		toSummon = "dummy_vision_1"
	else 
		toSummon = "dummy_vision_2"
	end
	local visionDuration = 10
	local location = spawnedUnit:GetAbsOrigin()
	local dummy_unit = CreateUnitByName(toSummon, location, false, nil, nil, spawnedUnit:GetTeam())
	local modifiers = { 
	"modifier_invulnerable", 						--The unit will be invulnerable
	"modifier_riki_permanent_invisibility", 		--The unit will be invisile
	"modifier_phased",								--The unit won't collide with others
	"MODIFIER_STATE_UNSELECTABLE"					--The unit won't be selectable
	}
	for i=1, table.getn(modifiers) do
		dummy_unit:AddNewModifier(dummy_unit, nil, modifiers[i], nil)
	end
	spawnedUnit:Destroy()
	
	--Here I created a vision unit, which will give us vision for a certain time
  	Timers:CreateTimer({
	  	endTime = visionDuration,
	  	callback = function()
	  	  dummy_unit:Destroy()
	  	end
  	})
end