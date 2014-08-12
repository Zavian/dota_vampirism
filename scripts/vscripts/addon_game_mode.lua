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

end

-- Create the game mode when we activate
function Activate()
	GameRules.AddonTemplate = VampirismGameMode()
	GameRules.AddonTemplate:InitGameMode()


	--game rules section
	--add here to maintain order
	GameRules:SetHeroRespawnEnabled(false)
end

function VampirismGameMode:InitGameMode()
	--load util
	--load vampirism
	print( "[VAMPIRISM] Game loaded." )
	print("")

	--loading the thinkers and listeners
	GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 2 )
	print("[BRAIN] My brain is rdy")

	--ListenToGameEvent('dota_player_killed', Dynamic_Wrap(VampirismGameMode, 'OnDotaPlayerKilled'), self)
	ListenToGameEvent('entity_killed', Dynamic_Wrap(VampirismGameMode, 'OnEntityKilled'), self)
	print("[BRAIN] Looking for dead ppl")

	print("")
end

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

	--local killedUnit = EntIndexToHScript( keys.entindex_killed )

	--This gets fired when an entity is killed.
	--Its purpose it's to get a farmer to a vampire, but for now it will do nothing...
	--TODO: Check if the entity it's a hero or a summoned creature (like a worker)

	local id = keys.entindex_killed
	print("[OnEntityKilled] "..id.." fired the event...")

	hscript  = EntIndexToHScript(id)
	player = hscript:GetPlayerID()
	isPlayer = hscript:IsPlayer()
	model = hscript:GetModelName()
	team = hscript:GetTeam()

	--if(isPlayer) then print("[OnEntityKilled] ..and that's a player!")
	--else print("[OnEntityKilled] ...and it's gone.")
	--end

	print("[OnEntityKilled] The dead model is ".. model)

	print("")

	if hscript and hscript:IsRealHero() then
		local newItem = CreateItem( "item_tombstone", hscript, hscript )
		newItem:SetPurchaseTime( 0 )
		newItem:SetPurchaser( hscript )
		local tombstone = SpawnEntityFromTableSynchronous( "dota_item_tombstone_drop", {} )
		tombstone:SetContainedItem( newItem )
		tombstone:SetAngles( 0, RandomFloat( 0, 360 ), 0 )
		FindClearSpaceForUnit( tombstone, hscript:GetAbsOrigin(), true )
	end


	if(model == MODEL_OMNI and team == TEAM_RADIANT) then
		--hscript:SetTeam(6)
		--print(hscript:GetContext("position")) --[[Returns:Vector
		--Returns the supplied position moved to the ground. Second parameter is an NPC for measuring movement collision hull offset.
		--]]
		--hscript:SetOwner(nil)

		--hscript:SetModel(nil)
		--hscript:SetModel(MODEL_NIGHT)
		--hscript:SetModelScale(0.7)
		--local hero = PlayerResource:ReplaceHeroWith(playerID, 'npc_dota_hero_invoker', 0, 0)
		--PlayerResource:ReplaceHeroWith(player, "npc_dota_hero_night_stalker", 0, 0)
		--print("[DEBUG] Trying to create the hero.")
		--test = CreateHeroForPlayer("dota_hero_night_stalker", hscript)  --crashes everything...
		--print("[DEBUG] Hero created!")
		--print(test)


	elseif (model == MODEL_NIGHT and team == TEAM_DIRE) then
		Msg("Banana!")
	end


	--if(team == TEAM_RADIANT) then --radiant dead
	--	hscript:SetTeam(TEAM_DIRE)
	--	hscript:SetModel(nil)
	--	hscript:SetModel(MODEL_NIGHT)
	--	hscript:SetModelScale(0.7)
	--elseif(team == TEAM_DIRE) then --dire dead
	--	hscript:SetTeam(TEAM_RADIANT)
	--	hscript:SetModel(nil)
	--	hscript:SetModel(MODEL_OMNI)
	--	hscript:SetModelScale(1.1)
	--end
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