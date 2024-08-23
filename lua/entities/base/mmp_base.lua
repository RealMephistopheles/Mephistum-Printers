DEFINE_BASECLASS("base_gmodentity")

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.Author = "Mephisto"
ENT.Category = "Mephistum Printers"

ENT.Spawnable = true
ENT.AdminOnly = true

DisableSpawnSound = false

ENT.GlobalSettings = {
    model = "models/props_c17/consolebox01a.mdl",
    color = Color( 255, 255, 255),
    material = "models/debug/debugwhite"
}
