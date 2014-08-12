-- Guesses on factions:
-- 1 = Neutral
-- 2 = Radiant
-- 3 = Dire
-- 4 = Events?
-- 5 = ???


function OnSpellStart(keys)
	local caster = keys.caster
	local team = caster:GetTeam()
	
	if(team == TEAM_RADIANT) then
		GameRules:SendCustomMessage("Nice try, but only Vampires have the power of like.", int team, 1)
	else 
		GameRules:SendCustomMessage("WIP", int team, 1)
	end
	

	print("[DATADRIVEN] A ghoul got something in its mail")
	print(unitname.."\n")

end