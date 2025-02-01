include("shared.lua")

local material = Material("vgui/white")
local colorgreen = Color(0, 255, 0)
local colorred = Color(205, 0, 0)

function SWEP:Initialize()
    self:CreateGhostModel()
end

function SWEP:PostDrawViewModel()
	local ow = self:GetOwner()
	if (ow ~= LocalPlayer()) then return end

	local trace = util.QuickTrace(ow:EyePos(), ow:GetAimVector() * 150, player:GetAll())
	if (not trace.Hit) then return end

	local traceNormal = trace.HitNormal
    local upVec = Vector(0, 0, 1)

    local angle = math.acos(upVec:GetNormalized():Dot(traceNormal:GetNormalized()))
    angle = math.deg(angle)

	local colortoapply = colorgreen
	if (angle >= 5 or angle <= -5) then
		colortoapply = colorred
	end

	local spawnpos = trace.HitPos + Vector(0, 0, 26)

	if IsValid(self.GhostModel) then
        self.GhostModel:SetPos(spawnpos)
        self.GhostModel:SetAngles(Angle(-90, ow:EyeAngles()[2] + 90, 0))

        for i = 0, self.GhostModel:GetNumBodyGroups() - 1 do
            self.GhostModel:SetSubMaterial(i, "models/debug/debugwhite")
        end

		cam.Start3D()
        render.SetColorModulation(colortoapply.r / 255, colortoapply.g / 255, colortoapply.b / 255)
        render.SetBlend(0.5)
        self.GhostModel:DrawModel()
        render.SetBlend(1)
        render.SetColorModulation(1, 1, 1)
		render.DrawLine(spawnpos, spawnpos + (ow:GetAimVector() * Vector(1, 1, 0):GetNormalized()) * TTT_SPEED_CAMERA.CVARS.speed_camera_range, colorred, true)
		cam.End3D()
    end
end

function SWEP:CreateGhostModel()
    if IsValid(self.GhostModel) then return end
    self.GhostModel = ClientsideModel("models/speed_camera/ent_speed_camera/ent_speed_camera.mdl", RENDERGROUP_TRANSLUCENT)
    if IsValid(self.GhostModel) then
        self.GhostModel:SetNoDraw(true)
    end
end

function SWEP:RemoveGhostModel()
    if IsValid(self.GhostModel) then
        self.GhostModel:Remove()
        self.GhostModel = nil
    end
end

function SWEP:Holster()
    self:RemoveGhostModel()
    return true
end

function SWEP:OnRemove()
    self:RemoveGhostModel()
end