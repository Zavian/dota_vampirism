BUILD_TIME=1.0

function getBuildingPoint(keys)
	--BuildingHelper:AddUnit(keys.caster)
	local point = BuildingHelper:AddBuildingToGrid(keys.target_points[1], 2, keys.caster)
	if point ~= -1 then		
		local farm = CreateUnitByName("building_home_human", point, false, nil, nil, keys.caster:GetTeam())
		BuildingHelper:SetForceUnitsAway(false)
		BuildingHelper:AddBuilding(farm)
		farm:UpdateHealth(BUILD_TIME, true, .85)
		farm:SetHullRadius(128)
		farm:SetControllableByPlayer( keys.caster:GetPlayerID(), true )
	else
		--Fire a game event here and use Actionscript to let the player know he can't place a building at this spot.
	end
end