include("shared.lua")

local imgui = include("imgui.lua")

surface.CreateFont( "Mephistum_Normal", {
	font = "ChatFont",
	size = 32,
	antialias = true,

} )

surface.CreateFont( "Mephistum_Medium", {
	font = "ChatFont",
	size = 26,
	antialias = true,

} )

surface.CreateFont( "Mephistum_Small", {
	font = "ChatFont",
	size = 14,
	antialias = true,

} )

function ENT:DrawTranslucent()
    self:DrawModel()
    self:SetColor(self.GlobalSettings.color)
    self:SetMaterial( self.GlobalSettings.material )

    storageVar = -self:GetNWInt( "pStorage" ) / self:GetNWInt( "pMaxStorage" ) * 100

    local HealthVar = self:GetNWInt( "pHealth" ) / self:GetNWInt( "pMaxHealth" ) * 100

    if imgui.Entity3D2D(self, Vector(-16, -15, 10.8), Angle(0, 90, 0), 0.1) then

        surface.SetDrawColor(0, 0, 0, 200)
        surface.DrawRect(0, 0, 305, 305)

        surface.SetDrawColor(0, 0, 0, 125)
        surface.DrawRect(5, 5, 295, 30)

        draw.SimpleText(self.printerName, "Mephistum_Normal", 152.5, 17, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        surface.SetDrawColor(0, 0, 0, 125)
        surface.DrawRect(5, 40, 295, 30)

        draw.SimpleText( string.format(" Level : %s", self:GetNWInt( "pLevel" ) ), "Mephistum_Normal", 152.5, 53, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        surface.SetDrawColor(0, 0, 0, 125)
        surface.DrawRect( 5 , 75, 295, 125 )

        surface.SetDrawColor( color_black )
        surface.DrawRect( 14.5 , 79.5, 42.5, 117 )

        surface.SetDrawColor( self.GlobalSettings.color )
        surface.DrawRect( 15 , 195, 40, storageVar * 1.16 )

        draw.SimpleText( string.format("$%u / $%u", self:GetNWInt( "pStorage" ), self:GetNWInt( "pMaxStorage" ) ), "Mephistum_Small", 177, 95, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        if imgui.xTextButton( "Upgrade Storage", "!Roboto@12", 80, 107, 200, 15, 1) then
            self:EmitSound("buttons/button15.wav")
            net.Start("NWUpgradeStorage")
            net.WriteEntity(self)
            net.WriteEntity(LocalPlayer())
            net.SendToServer()
        end 

        draw.SimpleText( string.format("$%s / %4.2f secs", self:GetNWInt("pAmount") * self:GetNWInt("pLevel"), self:GetNWInt( "pSpeed" )), "Mephistum_Small", 185, 140, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        if imgui.xTextButton("Upgrade Speed", "!Roboto@12", 80, 160, 200, 15, 1) then
            self:EmitSound("buttons/button15.wav")
            net.Start("NWUpgradeSpeed")
            net.WriteEntity(self)
            net.WriteEntity(LocalPlayer())
            net.SendToServer()
        end 

        if imgui.xTextButton("Level Up", "!Roboto@12", 80, 177, 200, 15, 1) then
            self:EmitSound("buttons/button15.wav")
            net.Start("NWUpgradeLevel")
            net.WriteEntity(self)
            net.WriteEntity(LocalPlayer())
            net.SendToServer()
        end
        
        surface.SetDrawColor(0, 0, 0, 125)
        surface.DrawRect( 5 , 205, 295, 95 )

                                
        if imgui.xTextButton("Get Money", "!Roboto@12", 10, 215, 284, 20, 1) then
            self:EmitSound("buttons/button15.wav")
            net.Start("NWGetMoney")
            net.WriteEntity(self)
            net.WriteEntity(LocalPlayer())
            net.SendToServer()
        end
        
        surface.SetDrawColor( 0, 0, 0, 125 )
        surface.DrawRect( 10 , 240, 285, 24)
        
        surface.SetDrawColor( 0, 255, 0, 125)
        surface.DrawRect( 12.5, 242.5, HealthVar * 2.81, 20)

        draw.SimpleText(string.format("%s / %s", self:GetNWInt( "pHealth" ), self:GetNWInt( "pMaxHealth" )), "Mephistum_Small", 152.5, 252, Color( 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        draw.SimpleText( self:CPPIGetOwner():Nick() , "Mephistum_Medium", 152.5, 275, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        imgui.End3D2D()
      end
end