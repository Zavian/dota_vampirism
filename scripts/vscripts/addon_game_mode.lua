-- Generated from template

require('util')
require('vampirism')



if VampirismGameMode == nil then
	VampirismGameMode = class({})
end

function Precache( context )
	--[[
		Precache things we know we'll use.  Possible file types include (but not limited to):
			PrecacheResource( "model", "*.vmdl", context )
			PrecacheResource( "soundfile", "*.vsndevts", context )
			PrecacheResource( "particle", "*.vpcf", context )
			PrecacheResource( "particle_folder", "particles/folder", context )

	]]
	--PrecacheModel("models/heroes/nightstalker/nightstalker.vmdl", context)
	--PrecacheModel("models/heroes/omniknight/omniknight.vmdl", context)
	--PrecacheModel("models/heroes/death_prophet/death_prophet.vmdl", context)
	--PrecacheModel("models/heroes/life_stealer/life_stealer.vmdl", context)
	--PrecacheModel(TREANT, context)


	--This will precache all the models I want
	--From the ALL array
	for i=1, table.getn(ALL) do
		PrecacheUnitByNameSync(ALL[i], context)
		--print(ALL[i])
	end
	print("[VAMPIRISM] Precached all")

end

-- Create the game mode when we activate
function Activate()
	GameRules.AddonTemplate = VampirismGameMode()
	GameRules.AddonTemplate:InitGameMode()


	--game rules section
	--add here to maintain order
	--GameRules:SetHeroRespawnEnabled(false)
	GameRules:SetSameHeroSelectionEnabled(true)

end

function VampirismGameMode:InitGameMode()
	--load util
	--load vampirism
	print( "[VAMPIRISM] Game loaded" )
	print("")

	--loading the thinkers and listeners
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 2 )
	print("[BRAIN] My brain is rdy")

	--ListenToGameEvent('dota_player_killed', Dynamic_Wrap(VampirismGameMode, 'OnDotaPlayerKilled'), self)
	ListenToGameEvent('entity_killed', Dynamic_Wrap(VampirismGameMode, 'OnEntityKilled'), self)
	print("[BRAIN] Looking for dead ppl")

	--ListenToGameEvent('player_spawn', Dynamic_Wrap(VampirismGameMode, 'OnPlayerSpawn'), self)

	print("")
end

--function VampirismGameMode:OnPlayerSpawn(keys)
--	print("")
--	PrintTable(keys, nil, nil)
--	print("")
--end

-- Evaluate the state of the game
function VampirismGameMode:OnThink()
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		--print( "Template addon script is running." )
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end


	return 1
end

--function VampirismGameMode:OnDotaPlayerKilled(keys) 
--	local id = keys.PlayerID
--	print(id)
--	print(PlayerResource:GetTeam(id))
--end




function VampirismGameMode:OnEntityKilled(keys) 
	--This gets fired when an entity is killed.
	--PrintTable(keys, nil, nil)

	local id = keys.entindex_killed
	local killer = keys.entindex_attacker
	print("[OnEntityKilled] "..id.." fired the event...")
	hscript  = EntIndexToHScript(id)
	model = hscript:GetModelName()
	if(model ~= MODEL_LIFE) then
		player = hscript:GetPlayerID()
		isPlayer = hscript:IsPlayer()	
		team = hscript:GetTeam()

		

		print("[OnEntityKilled] The dead model is ".. model)
		if (hscript and hscript:IsRealHero() and model == MODEL_OMNI and team == TEAM_RADIANT) then	
			addKiller(killer)

			PlayerResource:ReplaceHeroWith(player, DEATHPROPHET, 0, 0)		
			print("[OnEntityKilled] A player has been killed. Changed its model.")

			local table = Entities:FindByClassname(nil, DEATHPROPHET)
			if(table and table:GetTeam() == TEAM_RADIANT) then
				local ability = table:FindAbilityByName("death_prophet_become_life_protector")
				ability:UpgradeAbility()
			end

		elseif (hscript and hscript:IsRealHero() and model == MODEL_NIGHT and team == TEAM_DIRE) then
			GameRules:SendCustomMessage("You have killed a Vampire!", TEAM_RADIANT, 1)
			GameRules:SendCustomMessage("A Vampire has been killed!", TEAM_DIRE, 1)
			print("[OnEntityKilled] A Vampire died. Damn you...")

		end
	end
	print("")
end	

function VampirismGameMode:HandleEventError(name, event, err)
  -- This gets fired when an event throws an error

  -- Log to console
  print(err)

  -- Ensure we have data
  name = tostring(name or 'unknown')
  event = tostring(event or 'unknown')
  err = tostring(err or 'unknown')

  -- Tell everyone there was an error
  print("[BUG]" .. name .. ' threw an error on event ' .. event)
  print("[BUG] " .. err)
  --Say(nil, name .. ' threw an error on event '..event, false)
  --Say(nil, err, false)

  -- Prevent loop arounds
  if not self.errorHandled then
    -- Store that we handled an error
    self.errorHandled = true
    -- End the gamemode
    --self:EndGamemode()
  end
end