include("shared.lua")

local color = Color(206, 0, 0)

function ENT:Initialize()
    net.Receive("TTT2_Speed_Camera_OwnerPopup", function()
        local icon = Material("vgui/ttt/weapon_speed_camera_gun.png") -- Lade das Material
        local victim = net.ReadPlayer()

        MSTACK:AddColoredImagedMessage(
            "You have killed " .. victim:GetName() .. ".",
            Color(205, 0, 0),
            icon,
            "Speed Camera"
        )
    end)

    hook.Add("HUDPaint", self, function()
        if (LocalPlayer():GetTeam() ~= "traitors") then return end

        local screenPos = {}
        local textPos = self:GetPos() + Vector(0, 0, 40)

        cam.Start3D()
        screenPos = textPos:ToScreen()
        cam.End3D()

        local distance = (self:GetPos() - LocalPlayer():GetPos()):Length() * 0.01905
        cam.Start2D()
        draw.DrawText("Speed camera\n" .. string.format("%.2f m", distance), "Default", screenPos.x, screenPos.y, color, TEXT_ALIGN_CENTER)
        cam.End2D()

        if (not LocalPlayer():IsLineOfSightClear(self:GetPos()) or not TTT_SPEED_CAMERA.CVARS.speed_camera_show_range or self:GetNWInt("charges", TTT_SPEED_CAMERA.CVARS.speed_camera_charges) <= 0) then return end

        cam.Start3D()
        render.DrawLine(self:GetPos(), self:GetPos() + self:GetRight() * TTT_SPEED_CAMERA.CVARS.speed_camera_range, color, true)
        cam.End3D()
    end)
end

function ENT:Draw()
    self:DrawModel()
end