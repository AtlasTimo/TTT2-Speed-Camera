SWEP.PrintName			= "Speed Camera"
SWEP.Author				= "Atlas"
SWEP.Instructions		= "Place the speed camera and wait for it to catch someone sprinting!"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.Slot				= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= true
SWEP.DrawCrosshair		= true

SWEP.HoldType 	= "pistol"
SWEP.ViewModelFOV = 54
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/speed_camera/c_speed_camera/c_speed_camera.mdl"
SWEP.WorldModel = "models/speed_camera/w_speed_camera/w_speed_camera.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true

SWEP.Icon 		= "VGUI/ttt/weapon_speed_camera_gun.png"

SWEP.Base 			= "weapon_tttbase"
SWEP.Kind 			= WEAPON_EQUIP2
SWEP.AutoSpawnable 	= false
SWEP.AmmoEnt 		= "item_ammo_ttt"
SWEP.CanBuy 		= {ROLE_TRAITOR}
SWEP.InLoadoutFor 	= nil
SWEP.LimitedStock 	= true
SWEP.AllowDelete 	= false
SWEP.AllowDrop 		= true

if CLIENT then
	SWEP.EquipMenuData = {
		type = "Weapon",
		desc = "Place the speed camera and wait for it to catch someone sprinting!"
	};
end
