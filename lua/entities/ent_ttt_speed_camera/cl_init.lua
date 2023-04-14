include("shared.lua")

function ENT:Initialize()
    hook.Add("HUDPaint", self, function()
        if (LocalPlayer():GetTeam() ~= "traitors") then return end

        local screenPos = {}
        local textPos = self:GetPos() + Vector(0, 0, 40)

        cam.Start3D()
        screenPos = textPos:ToScreen()
        cam.End3D()

        cam.Start2D()
        draw.DrawText("Speed camera\n" .. tostring(math.floor((self:GetPos() - LocalPlayer():GetPos()):Length())), "Default", screenPos.x, screenPos.y, Color(206, 0, 0), TEXT_ALIGN_CENTER)
        cam.End2D()
    end)
end

function ENT:Draw()
    self:DrawModel()
end