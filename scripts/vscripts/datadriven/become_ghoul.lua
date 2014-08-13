function OnSpellStart(keys)
	GameRules:SendCustomMessage("A ghoul is coming back...", TEAM_DIRE, 1)
end

function OnChannelSucceded(keys)
	local caster = keys.caster
	local team = caster:GetTeam()
	local unitname = caster:GetUnitName()

	caster:SetTeam(TEAM_DIRE)
	PlayerResource:ReplaceHeroWith(caster:GetPlayerID(), LIFESTEALER, 0, 0)
	
end