include("shared.lua")

function SWEP:PrimaryAttack()

end

local material = Material("vgui/white")
local color = Color(0, 255, 0)

function SWEP:PostDrawViewModel()
	local ow = self:GetOwner()
	if (ow ~= LocalPlayer()) then return end

	local trace = util.QuickTrace(ow:EyePos(), ow:GetAimVector() * 150, player:GetAll())
	if (not trace.Hit) then return end

	local traceNormal = trace.HitNormal
    local upVec = Vector(0, 0, 1)

    local angle = math.acos(upVec:GetNormalized():Dot(traceNormal:GetNormalized()))
    angle = math.deg(angle)

	if (angle >= 5 or angle <= -5) then
		color = Color(255, 0, 0)
	else
		color = Color(0, 255, 0)
	end

	local traceHitPos = trace.HitPos
	local quality = 20

	cam.Start3D()
	render.SetMaterial(material)
	render.DrawWireframeSphere(traceHitPos, 10, quality, quality, color, true)
	cam.End3D()
end