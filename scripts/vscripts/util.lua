print("[VAMPIRISM] Util loaded")

function PrintTable(t, indent, done)
	--print ( string.format ('PrintTable type %s', type(keys)) )
    if type(t) ~= "table" then return end

    done = done or {}
    done[t] = true
    indent = indent or 0

    local l = {}
    for k, v in pairs(t) do
        table.insert(l, k)
    end

    table.sort(l)
    for k, v in ipairs(l) do
        -- Ignore FDesc
        if v ~= 'FDesc' then
            local value = t[v]

            if type(value) == "table" and not done[value] then
                done [value] = true
                print(string.rep ("\t", indent)..tostring(v)..":")
                PrintTable (value, indent + 2, done)
            elseif type(value) == "userdata" and not done[value] then
                done [value] = true
                print(string.rep ("\t", indent)..tostring(v)..": "..tostring(value))
                PrintTable ((getmetatable(value) and getmetatable(value).__index) or getmetatable(value), indent + 2, done)
            else
                if t.FDesc and t.FDesc[v] then
                    print(string.rep ("\t", indent)..tostring(t.FDesc[v]))
                else
                    print(string.rep ("\t", indent)..tostring(v)..": "..tostring(value))
                end
            end
        end
    end
end

function addKiller(KillerID)
    KILLERS[KillerIndex] = KillerID
    KillerIndex = KillerIndex + 1
    print("[UTIL] A new killer came")
end

function SearchForSecondKiller(SuspectTable, KnownKiller)
    if(table.getn(KILLERS) == 2) then
        if(KILLERS[0] == KnownKiller) then return KILLERS[1]
        else return KILLERS[0]
        end
    else
        if(SuspectTable[0] == KnownKiller) then return SuspectTable[1]
        else return SuspectTable[0]
        end
    end
end

function RemoveEmptySpell(entity)
    if(entity:FindAbilityByName("empty_spell")) then entity:RemoveAbility("empty_spell") end
    print("[UTIL] Spell removed")
end

function SwapSpells(who, whatItHas, whatItNeeds) 
    if(who:FindAbilityByName(whatItHas)) then
        who:RemoveAbility(whatItHas)
        who:AddAbility(whatItNeeds)
    end
end


