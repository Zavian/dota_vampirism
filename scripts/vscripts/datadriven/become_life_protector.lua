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
			--RemoveEmptySpell(stalkers[i])
			if(stalkers[i]:FindAbilityByName("banish_life_protector"):GetLevel() == 0) then
				stalkers[i]:FindAbilityByName("banish_life_protector"):UpgradeAbility()
			else break
			end
		end
	end


	--Just to explain what happens here:
	--if the vampire hasn't the summon_ghoul_1 level 1 here we level it
	--if he has the summon_ghoul_1 level 1 we swap it with the summon_ghoul_2 and we level it
	--if he has the level 2 of the second spell we check if the vampire has summon_ghoul_1 level 1, if not we level that up
	--if yes we swap it with summon_ghoul_2 and we level it
	--Kinda difficult to see, but pretty easy as concept.

	if(table.getn(KILLERS) < 4) then		
		killer = EntIndexToHScript(KILLERS[0])
		if(killer) then
			if(killer:FindAbilityByName("summon_ghoul_1")) then
				spellLevel = killer:FindAbilityByName("summon_ghoul_1"):GetLevel()
				if(spellLevel == 0) then killer:FindAbilityByName("summon_ghoul_1"):UpgradeAbility()
				elseif(spellLevel == 1) then
					SwapSpells(killer, "summon_ghoul_1", "summon_ghoul_2")
					killer:FindAbilityByName("summon_ghoul_2"):UpgradeAbility()
				end
			elseif(killer:FindAbilityByName("summon_ghoul_2")) then
				local whoToBuff = nil
				if(stalkers[1] == killer) then 
					whoToBuff = stalkers[2]
				else 
					whoToBuff = stalkers[1]
				end
				if(whoToBuff:FindAbilityByName("summon_ghoul_1")) then
					spellLevel = whoToBuff:FindAbilityByName("summon_ghoul_1"):GetLevel()
					if(spellLevel == 0) then whoToBuff:FindAbilityByName("summon_ghoul_1"):UpgradeAbility()
						elseif(spellLevel == 1) then
							SwapSpells(whoToBuff, "summon_ghoul_1", "summon_ghoul_2")
							whoToBuff:FindAbilityByName("summon_ghoul_2"):UpgradeAbility()
						end
					end
				end
		end
	else
		--Must create the event of rage!
		print("[DATADRIVEN] He went nuts...")
	end
	

	print("")

	
end