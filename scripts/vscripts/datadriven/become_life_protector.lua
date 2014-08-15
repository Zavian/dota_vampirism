function OnSpellStart(keys)
	GameRules:SendCustomMessage("A Life Protector is coming back...", TEAM_DIRE, 1)
end

function OnChannelSucceded(keys)
	print("[DATADRIVEN] become_life_protector fired")
	local caster = keys.caster
	local team = caster:GetTeam()
	local unitname = caster:GetUnitName()

	print("[DATADRIVEN] Replacing caster to "..TREANT)
	PlayerResource:ReplaceHeroWith(caster:GetPlayerID(), TREANT, 0, 0)
	

	--Now I'm going to give both the Vampires the banish spell
	local stalkers = Entities:FindAllByClassname(NIGHTSTALKER)
	if(stalkers) then
		for i = 1, table.getn(stalkers) do
			RemoveEmptySpell(stalkers[i])
			if(not stalkers[i]:FindAbilityByName("banish_life_protector")) then
				stalkers[i]:AddAbility("banish_life_protector")
			else break
			end
		end
	end


	if(table.getn(KILLERS) < 4) then		
		killer = EntIndexToHScript(KILLERS[0])
		if(killer) then
			if(killer:FindAbilityByName("summon_ghoul_1")) then
				if(killer:FindAbilityByName("summon_ghoul_2")) then
					--Killer has both summon ghouls
					local whoToBuff = nil
					if(stalkers[1] == killer) then whoToBuff = stalkers[2]
					else whoToBuff = stalkers[1]
					end
					--whoToBuff = EntIndexToHScript(whoToBuff)
					RemoveEmptySpell(whoToBuff)
					if(whoToBuff:FindAbilityByName("summon_ghoul_1")) then whoToBuff:AddAbility("summon_ghoul_2")
					else whoToBuff:AddAbility("summon_ghoul_1")
					end
				else 
					--Killer has first ghoul, but not the second one
						RemoveEmptySpell(killer)
						killer:AddAbility("summon_ghoul_2")
				end
			else 
					--Killer hasn't the first ghoul
					RemoveEmptySpell(killer)
					killer:AddAbility("summon_ghoul_1")
			end
		end
	else
		--Must create the event of rage!
		print("[DATADRIVEN] He went nuts...")
	end
	

	print("")

	
end