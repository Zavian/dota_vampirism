function OnSpellStart(keys)
	GameRules:SendCustomMessage("A ghoul is coming back...", TEAM_DIRE, 1)
end

function OnChannelSucceded(keys)
	print("[DATADRIVEN] become_ghoul fired")
	local caster = keys.caster
	local team = caster:GetTeam()
	local unitname = caster:GetUnitName()

	print("[DATADRIVEN] Replacing caster to "..LIFESTEALER)
	PlayerResource:ReplaceHeroWith(caster:GetPlayerID(), LIFESTEALER, 0, 0)

	print("[DATADRIVEN] Changing caster's team to "..TEAM_DIRE)
	local table = Entities:FindByClassname(nil, LIFESTEALER)

	if(table and table:GetTeam() == TEAM_RADIANT) then
		table:SetTeam(TEAM_DIRE)
		--table:SetTeam(TEAM_DIRE)
		print("[DATADRIVEN] Success")
		--PrintTable(table, nil, nil)

		table = Entities:FindByClassname(nil, LIFESTEALER)
		print(table:GetTeam())
	end

	print("")

	
end