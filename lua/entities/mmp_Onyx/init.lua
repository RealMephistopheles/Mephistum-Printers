AddCSLuaFile()
AddCSLuaFile("imgui.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

local networkStrings = {
    "NWUpgradeStorage",
    "NWUpgradeSpeed",
    "NWUpgradeLevel",
    "NWGetMoney"
}

for k,v in pairs(networkStrings) do
    util.AddNetworkString( v )
end

function ENT:Initialize()
    self:SetModel(self.GlobalSettings.model)
    self:SetColor(self.GlobalSettings.color)

    self:PhysicsInit( SOLID_VPHYSICS )
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )

    self:SetNWInt( "pHealth", self.health)
    self:SetNWInt( "pMaxHealth", self.maxHealth )
    self:SetNWInt( "pSpeed", self.speed )
    self:SetNWInt( "pMaxSpeed", self.maxSpeed)
    self:SetNWInt( "pStorage", self.storage )
    self:SetNWInt( "pMaxStorage", self.maxStorage )
    self:SetNWInt( "pLevel", self.level )
    self:SetNWInt( "pMaxLevel", self.maxLevel )
    self:SetNWInt( "pAmount", self.amount )

    self:SetNWInt( "pStorageUpgradeCost", self.StorageUpgradeCost)
    self:SetNWInt( "pSpeedUpgradeCost", self.SpeedUpgradeCost)
    self:SetNWInt( "pLevelUpgradeCost", self.LevelUpgradeCost)

    for k,v in pairs(networkStrings) do
        util.AddNetworkString( v )
    end    

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
    
    if DisableSpawnSound == false then
        self:EmitSound("garrysmod/save_load2.wav", 65, 100, 20)
    end
end

function ENT:Think()

    if self:GetNWInt( "pStorage" ) < self:GetNWInt( "pMaxStorage" ) then
        if self:GetNWInt("LastPrint", 0) + self:GetNWInt( "pSpeed" ) <= CurTime() then
            local money = self:GetNWInt( "pStorage" ) + self:GetNWInt("pAmount") * self:GetNWInt( "pLevel" )
            self:SetNWInt( "pStorage", math.Clamp(money, 0, self:GetNWInt( "pMaxStorage" ) ) )
            self:SetNWInt("LastPrint", CurTime())
        end
    end

    if self:GetNWInt( "pHealth" ) <= 0 then
        self:Remove()
    end

    self:NextThink(CurTime())
end

function ENT:OnTakeDamage( CTakeDamageInfo )

    self:SetNWInt( "pHealth", self:GetNWInt( "pHealth" ) - CTakeDamageInfo:GetDamage())

end

net.Receive("NWUpgradeStorage", function()
    local ePrinter = net.ReadEntity()
    local ply = net.ReadEntity()

    if ply:getDarkRPVar("money") > ePrinter:GetNWInt( "pStorageUpgradeCost") then
        if ePrinter.storageLevel < ePrinter.maxStorageLevel then
            ePrinter.storageLevel = ePrinter.storageLevel + 1
                ply:addMoney( -math.floor(ePrinter:GetNWInt( "pStorageUpgradeCost")) )
                --DarkRP.notify(ply, 1, 4, "You've upgraded your printer storage for $" .. math.floor(ePrinter:GetNWInt( "pStorageUpgradeCost")))

                ePrinter:SetNWInt( "pStorageUpgradeCost", ePrinter:GetNWInt( "pStorageUpgradeCost") * 1.100 )

                ePrinter:SetNWInt( "pMaxStorage", ePrinter:GetNWInt( "pMaxStorage") + 400 )
            else DarkRP.notify(ply, 0, 4, "This upgrade is already max level!") end
    else DarkRP.notify(ply, 1, 4, "You don't have enough money for that!") end
end)


net.Receive("NWUpgradeSpeed", function()
    local ePrinter = net.ReadEntity()
    local ply = net.ReadEntity()

    if ply:getDarkRPVar("money") > ePrinter:GetNWInt( "pSpeedUpgradeCost") then
        if ePrinter.speedLevel < ePrinter.maxSpeedLevel then
            ePrinter.speedLevel = ePrinter.speedLevel + 1
            ply:addMoney( -math.floor(ePrinter:GetNWInt( "pSpeedUpgradeCost")) )
            --DarkRP.notify(ply, 1, 4, "You've upgraded your printer speed for $" .. math.floor(ePrinter:GetNWInt( "pSpeedUpgradeCost")))

            ePrinter:SetNWInt( "pSpeedUpgradeCost", ePrinter:GetNWInt( "pSpeedUpgradeCost") * 1.100 )

            ePrinter:SetNWInt( "pSpeed", ePrinter:GetNWInt( "pSpeed" ) / 1.05)
        else DarkRP.notify(ply, 0, 4, "This upgrade is already max level!") end
    else DarkRP.notify(ply, 1, 4, "You don't have enough money for that!") end
end)


net.Receive("NWUpgradeLevel", function()
    local ePrinter = net.ReadEntity()
    local ply = net.ReadEntity()
    
    if ply:getDarkRPVar("money") > ePrinter:GetNWInt( "pSpeedUpgradeCost") then
        if ePrinter:GetNWInt( "pLevel" ) < ePrinter.maxLevel then
            ply:addMoney( -math.floor(ePrinter:GetNWInt( "pLevelUpgradeCost")) )
            --DarkRP.notify(ply, 1, 4, "You've upgraded your printer level for $" .. math.floor(ePrinter:GetNWInt( "pLevelUpgradeCost")))

            ePrinter:SetNWInt( "pLevelUpgradeCost", ePrinter:GetNWInt( "pLevelUpgradeCost") * 1.100 )

            ePrinter:SetNWInt( "pLevel", ePrinter:GetNWInt( "pLevel" ) + 1)
        else DarkRP.notify(ply, 0, 4, "This upgrade is already max level!") end
    else DarkRP.notify(ply, 1, 4, "You don't have enough money for that!") end
end)

net.Receive("NWGetMoney", function() 
    local ePrinter = net.ReadEntity()
    local ply = net.ReadEntity()

    if ply && ply:IsValid() then
        if ePrinter:GetNWInt( "pStorage" ) > 0 then
            ply:addMoney( ePrinter:GetNWInt( "pStorage" ) )
            --DarkRP.notify(ply, 1, 4, "You've received $" .. ePrinter:GetNWInt( "pStorage" ) .. " from your printer!")
            ePrinter:SetNWInt( "pStorage", 0)
        end
    end
end)

scripted_ents.Register(ENT, "mmp_bronze")