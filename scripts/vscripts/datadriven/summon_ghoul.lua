function OnSpellStart(keys)
	local caster = keys.caster
	ability = caster:FindAbilityByName("summon_ghoul")
	if(ability) then
		level = ability:GetLevel()
		if(level == 1) then
			local creature = CreateHeroForPlayer("summoned_ghoul", caster)--("summoned_ghoul", caster:GetAbsOrigin(), true, caster:GetPlayerOwner(), caster, TEAM_DIRE)
		end			
	end
	--print(unitname.."\n")

end