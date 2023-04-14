TTT_SPEED_CAMERA = TTT_SPEED_CAMERA or {}
TTT_SPEED_CAMERA.CVARS = TTT_SPEED_CAMERA.CVARS or {}

local speed_camera_range = CreateConVar("ttt_speed_camera_range", "500", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local speed_camera_enemy_damage = CreateConVar("ttt_speed_camera_enemy_damage", "70", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local speed_camera_friendly_fire = CreateConVar("ttt_speed_camera_friendly_fire", "0", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})
local speed_camera_teammates_damage = CreateConVar("ttt_speed_camera_teammates_damage", "30", {FCVAR_NOTIFY, FCVAR_ARCHIVE, FCVAR_REPLICATED})

TTT_SPEED_CAMERA.CVARS.speed_camera_range = speed_camera_range:GetInt()
TTT_SPEED_CAMERA.CVARS.speed_camera_enemy_damage = speed_camera_enemy_damage:GetInt()
TTT_SPEED_CAMERA.CVARS.speed_camera_friendly_fire = speed_camera_friendly_fire:GetBool()
TTT_SPEED_CAMERA.CVARS.speed_camera_teammates_damage = speed_camera_teammates_damage:GetInt()

if SERVER then

  cvars.AddChangeCallback("ttt_speed_camera_enemy_damage", function(name, old, new)
    TTT_SPEED_CAMERA.CVARS.speed_camera_enemy_damage = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_speed_camera_friendly_fire", function(name, old, new)
    TTT_SPEED_CAMERA.CVARS.speed_camera_friendly_fire = util.StringToType(new, "bool")
  end, nil)

  cvars.AddChangeCallback("ttt_speed_camera_teammates_damage", function(name, old, new)
    TTT_SPEED_CAMERA.CVARS.speed_camera_teammates_damage = tonumber(new)
  end, nil)

  cvars.AddChangeCallback("ttt_speed_camera_range", function(name, old, new)
    TTT_SPEED_CAMERA.CVARS.speed_camera_range = tonumber(new)
  end, nil)

end

