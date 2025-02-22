AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + 1.0)

    local ow = self:GetOwner()
    local trace = util.QuickTrace(ow:EyePos(), ow:GetAimVector() * 150, player:GetAll())

    local traceNormal = trace.HitNormal
    local upVec = Vector(0, 0, 1)

    local angle = math.acos(upVec:GetNormalized():Dot(traceNormal:GetNormalized()))
    angle = math.deg(angle)

    if (angle >= 5 or angle <= -5) then return end

    ow.lastSpeedCameraExecution = CurTime()

    local ent = ents.Create("ent_ttt_speed_camera")
    ent:SetNWString("speedCameraName", "ttt_speed_camera")
    ent:SetNWInt("charges", TTT_SPEED_CAMERA.CVARS.speed_camera_charges)
    ent:Spawn()
    ent:SetName("ttt_speed_camera")
    ent.Owner = ow

    local spawnPos = trace.HitPos + Vector(0, 0, 26)

    ent:SetPos(spawnPos)
    local modelAngle = Angle(-90, ow:EyeAngles()[2] + 90, 0)
    ent:SetAngles(modelAngle)

    ow:StripWeapon("weapon_speed_camera")
end