local QBCore = exports['qb-core']:GetCoreObject()
---comment
---@param src any
---@return boolean
function NearBus(src)
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    for _, v in pairs(Config.NPCLocations.Locations) do
        local dist = #(coords - vec3(v.x, v.y, v.z))
        if dist < 20 then
            return true
        end
    end
    return false
end

RegisterNetEvent('qb-busjob:server:NpcPay', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local Payment = math.random(15, 25)
    if Player.PlayerData.job.name == "bus" then
        if NearBus(src) then
            local randomAmount = math.random(1, 5)
            local r1, r2 = math.random(1, 5), math.random(1, 5)
            if randomAmount == r1 or randomAmount == r2 then Payment = Payment + math.random(10, 20) end
            Player.Functions.AddMoney('cash', Payment)
        else
            DropPlayer(src, 'Attempting To Exploit')
        end
    else
        DropPlayer(src, 'Attempting To Exploit')
    end
end)
