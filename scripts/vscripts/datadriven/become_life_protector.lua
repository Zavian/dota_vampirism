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
			if(killer:FindAbilityByName("summon_ghoul")) then
				if(killer:FindAbilityByName("summon_ghoul"):GetLevel() == 2) then
					--Killer has summon ghoul level 2
					local whoToBuff = nil
					if(stalkers[1] == killer) then whoToBuff = stalkers[2]
					else whoToBuff = stalkers[1]
					end
					--whoToBuff = EntIndexToHScript(whoToBuff)
					RemoveEmptySpell(whoToBuff)
					if(whoToBuff:FindAbilityByName("summon_ghoul")) then 
						--Give the second level of the summon ghoul
						whoToBuff:FindAbilityByName("summon_ghoul"):UpgradeAbility()
					else 
						--Give first level of the summon ghoul
						whoToBuff:AddAbility("summon_ghoul")
						whoToBuff:FindAbilityByName("summon_ghoul"):UpgradeAbility()

					end
				else 
					--Give second level of the summon ghoul
					--RemoveEmptySpell(killer)
					killer:FindAbilityByName("summon_ghoul"):UpgradeAbility()
				end
			else 
					--Give first level of summon ghoul
					RemoveEmptySpell(killer)
					killer:AddAbility("summon_ghoul")
					killer:FindAbilityByName("summon_ghoul"):UpgradeAbility()
			end
		end
	else
		--Must create the event of rage!
		print("[DATADRIVEN] He went nuts...")
	end
	

	print("")

	
end