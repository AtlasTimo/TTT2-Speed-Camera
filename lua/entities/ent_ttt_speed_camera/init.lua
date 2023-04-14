AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

local shuttersound = Sound("shutter_sound.ogg")

function ENT:Initialize()
    self:SetModel("models/speed_camera/ent_speed_camera/ent_speed_camera.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:PhysWake()
    self:SetCollisionGroup(COLLISION_GROUP_NONE)

	local flashpos = self:GetBonePosition(1)

	self.flash = ents.Create( "env_lightglow" )
	self.flash:SetPos(flashpos)
	self.flash:SetAngles( Angle( 0, 0, 0 ) )
	self.flash:SetParent( self )
	self.flash:SetName( "flash" )
	self.flash:SetKeyValue( "rendercolor", "0 0 0 0" )
	self.flash:SetKeyValue( "HorizontalGlowSize", "300" )
	self.flash:SetKeyValue( "VerticalGlowSize", "300" )
	self.flash:SetKeyValue( "MinDist", "1300" )
	self.flash:SetKeyValue( "MaxDist", "1000" )
	self.flash:Spawn()
end

function ENT:Think()
	self.stuetzVektor = self:GetPos()
	self.richtungsVektor = self:GetRight() * TTT_SPEED_CAMERA.CVARS.speed_camera_range

	local allEnts = ents.FindInBox(self:GetPos() - self:GetUp() * 10 + self:GetForward() * 10, self:GetPos() + self:GetUp() * 10 - self:GetForward() * 10 + self:GetRight() * TTT_SPEED_CAMERA.CVARS.speed_camera_range * -1)
	local ow = self:GetOwner()

	for i, v in pairs(allEnts) do
		if (v:IsPlayer() and v:Alive() and v:GetObserverMode() == OBS_MODE_NONE and v:IsLineOfSightClear(self:GetPos())) then
			if (v:GetVelocity():Length() < 300 or (not TTT_SPEED_CAMERA.CVARS.speed_camera_friendly_fire and v:GetTeam() == ow:GetTeam())) then continue end
			if (v.lastSpeedCameraExecution == nil or v.lastSpeedCameraExecution + 5 < CurTime()) then
				local playeraimvector = Vector(v:GetAimVector().x, v:GetAimVector().y, 0)
				local speedcameraaimvector = self:GetRight()
				local currentangle = 	(playeraimvector.x * speedcameraaimvector.x + playeraimvector.y * speedcameraaimvector.y + playeraimvector.z * speedcameraaimvector.z) / 
										(playeraimvector:Length() * speedcameraaimvector:Length())

				currentangle = math.deg(math.acos(currentangle))

				if (currentangle <= 30) then
					self:EmitSound(shuttersound, 100, 100, 1)
					self.flash:Fire("Color", "255 40 40 255", "0")
					self.flash:Fire("Color", "0 0 0 0", "0.01")
					if (v:GetTeam() == ow:GetTeam()) then
						v:TakeDamage(TTT_SPEED_CAMERA.CVARS.speed_camera_teammates_damage, ow, nil)
					else
						v:TakeDamage(TTT_SPEED_CAMERA.CVARS.speed_camera_enemy_damage, ow, nil)
					end
					v.lastSpeedCameraExecution = CurTime()
				end
			end
		end
	end

	self:NextThink(CurTime() + 1 / 5)
	return true
end