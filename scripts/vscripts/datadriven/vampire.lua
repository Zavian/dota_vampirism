function SummonedGhoul(keys)
	local spawner = keys.caster
	local level = spawner:GetLevel()
	local spawnedGhoul = keys.target
	local spellNumber = 4--math.random(1, 4)
	local spellToAdd = {}
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