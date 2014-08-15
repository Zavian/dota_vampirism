print("[VAMPIRISM] Lua loaded")
TEAM_DIRE		= 3
TEAM_RADIANT 	= 2

--local creature = CreateUnitByName(NIGHTSTALKER, caster:GetAbsOrigin(), true, nil, nil, TEAM_DIRE) 
--creature:SetOwner(PlayerResource:GetPlayer(0))

--print(caster:GetPlayerOwner())
--print(creature:GetPlayerOwner())
--player = PlayerResource:GetPlayer(0)
--caster:SetTeam(TEAM_DIRE)
--player:SetTeam(TEAM_DIRE)


MODEL_DEATH 	= "models/heroes/death_prophet/death_prophet.vmdl"
MODEL_LIFE 		= "models/heroes/life_Stealer/life_Stealer.vmdl"
MODEL_NIGHT 	= "models/heroes/nightstalker/nightstalker.vmdl"
MODEL_OMNI 		= "models/heroes/omniknight/omniknight.vmdl"
MODEL_TREANT 	= "models/heroes/treant_protector/treant_protector.vmdl"

OMNI 			= "npc_dota_hero_omniknight"
NIGHTSTALKER 	= "npc_dota_hero_night_stalker"
DEATHPROPHET 	= "npc_dota_hero_death_prophet"
LIFESTEALER 	= "npc_dota_hero_life_stealer"
TREANT 			= "npc_dota_hero_treant"

ALL 			=	{
						NIGHTSTALKER,
						OMNI,
						DEATHPROPHET,
						LIFESTEALER,
						TREANT
					}


KILLERS = {}		--used for 
KillerIndex = 0



