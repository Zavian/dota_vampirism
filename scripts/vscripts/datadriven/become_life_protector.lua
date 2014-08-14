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


	--PrintTable(KILLERS, nil, nil)
	--print("0: "..KILLERS[0])
	--print("1: "..KILLERS[1])
	if(table.getn(KILLERS) < 4) then
		for i = 0, table.getn(KILLERS) do
			--looking at the vampires

			killer = EntIndexToHScript(KILLERS[i])

			--Adding the banish if the hero hasn't it
			if(killer and not killer:FindAbilityByName("banish_life_protector") and killer:GetModelName() == MODEL_NIGHT) then
				--The ability hasn't been found, going to remove the empty one and give him the banish
				RemoveEmptySpell(killer)
				killer:AddAbility("banish_life_protector")
			end

			if(killer) then
				if(killer:FindAbilityByName("summon_ghoul_1")) then
					if(killer:FindAbilityByName("summon_ghoul_2")) then
						--Killer has both summon ghouls
						SuspectKiller()
						otherKiller = SearchForSecondKiller()
						
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

		end
	end
	--Must create the event of rage!

	print("")

	
end