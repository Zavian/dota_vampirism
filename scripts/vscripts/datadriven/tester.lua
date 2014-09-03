--Factions
-- 1 = Neutral
-- 2 = Radiant
-- 3 = Dire
-- 4 = Events?
-- 5 = ???

function test(keys)
	print("Casted tested spell")
end

--Spell with test purposes
function OnSpellStart(keys)
	local caster = keys.caster
	local team = caster:GetTeam()
	local unitname = caster:GetUnitName()
	local teamName = ""

	if(team == 2) then caster:SetTeam(4)
	elseif (team==3) then caster:SetTeam(1)
	end

	--if(team == 3) then
	--	caster:SetTeam(4)
	--	team = 4
	--	teamName = "Radiant"
	--else
	--	caster:SetTeam(5)
	--	team = 5
	--	teamName = "Dire?"
	--
	--end

	--print("Changed caster's faction.\n".."Faction Name:"..teamName)
	--print("Caster:"..caster:GetSteamAccountID().."\n")
	print("[DATADRIVEN] Caster's faction:"..team)
	print(unitname.."\n")

end