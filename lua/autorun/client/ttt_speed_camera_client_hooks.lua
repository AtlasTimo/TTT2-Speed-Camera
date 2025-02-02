hook.Add("TTTRenderEntityInfo", "TTT2SpeedCameraRenderCharges", function(tData)
	local ent = tData:GetEntity()
	if not IsValid(ent) then return end

    if (ent:GetNWString("speedCameraName") ~= "ttt_speed_camera") then return end

	local speedCameraCharges = ent:GetNWInt("charges")
	local percentCharges = speedCameraCharges / TTT_SPEED_CAMERA.CVARS.speed_camera_charges * 100
	local drawText = "Charges: " .. speedCameraCharges
	local drawColor

	if (percentCharges >= 100) then
		drawColor = Color(30, 230, 30)
	elseif (percentCharges >= 80) then
		drawColor = Color(157, 209, 26)
	elseif (percentCharges >= 50) then
		drawColor = Color(202, 205, 33)
	elseif (percentCharges >= 25) then
		drawColor = Color(214, 139, 0)
	elseif (percentCharges >= 0) then
		drawColor = Color(170, 24, 24)
	else
		drawColor = Color(255, 255, 255)
	end

	tData:SetTitle("Speed Camera", Color(255, 255, 255))
	tData:EnableText(true)
	tData:EnableOutline(false)
    tData:SetSubtitle(drawText, drawColor, {})

	return true
end)