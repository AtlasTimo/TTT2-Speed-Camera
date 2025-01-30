include("shared.lua")

local color = Color(206, 0, 0)

function ENT:Initialize()
    self.charges = TTT_SPEED_CAMERA.CVARS.speed_camera_charges

    net.Receive("SpeedCameraChargesChanged", function()
        self.charges = net.ReadInt(32)
    end)

    hook.Add("HUDPaint", self, function()
        if (LocalPlayer():GetTeam() ~= "traitors") then return end

        local screenPos = {}
        local textPos = self:GetPos() + Vector(0, 0, 40)

        cam.Start3D()
        screenPos = textPos:ToScreen()
        cam.End3D()

        cam.Start2D()
        draw.DrawText("Speed camera\n" .. tostring(math.floor((self:GetPos() - LocalPlayer():GetPos()):Length())) .. "\nCharges: " .. self.charges, "Default", screenPos.x, screenPos.y, color, TEXT_ALIGN_CENTER)
        cam.End2D()

        if (not LocalPlayer():IsLineOfSightClear(self:GetPos()) || not TTT_SPEED_CAMERA.CVARS.speed_camera_show_range) then return end

        cam.Start3D()
        render.DrawLine(self:GetPos(), self:GetPos() + self:GetRight() * TTT_SPEED_CAMERA.CVARS.speed_camera_range, color, true)
        cam.End3D()
    end)
end

function ENT:Draw()
    self:DrawModel()
end