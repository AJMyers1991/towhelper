local useboom = 0

local function IsPlayerInTowTruck()
	local ped = PlayerPedId()
	local tvehicle = GetVehiclePedIsIn(ped)
	local tow1 = GetHashKey(Config.rollback1)
	local tow2 = GetHashKey(Config.rollback2)
	local tow3 = GetHashKey(Config.heavywrecker)
	local tow5 = GetHashKey(Config.rollback3)
	local tow6 = GetHashKey(Config.rollback4)
	return IsVehicleModel(tvehicle, tow1) or IsVehicleModel(tvehicle, tow2) or IsVehicleModel(tvehicle, tow3) or IsVehicleModel(tvehicle, tow5) or IsVehicleModel(tvehicle, tow6)
end

local function IsPlayerInHeavyWrecker()
	local ped = PlayerPedId()
	local hvehicle = GetVehiclePedIsIn(ped)
	local tow4 = GetHashKey(Config.heavywrecker)
	return IsVehicleModel(hvehicle, tow4)
end

local function VehicleSpeed()
	local ped = PlayerPedId()
	local svehicle = GetVehiclePedIsIn(ped)
	return GetEntitySpeed(svehicle)
end

CreateThread(function()
    while true do
		Wait(0)
		local ped = PlayerPedId()
		if Config.RollbackDisable == true and IsPlayerInTowTruck() and VehicleSpeed() > 1.0 then
			DisableControlAction(2, 60, true)
			DisableControlAction(2, 61, true)
			DisableControlAction(2, 62, true)
			DisableControlAction(2, 110, true)
			DisableControlAction(2, 111, true)
			DisableControlAction(2, 112, true)
			DisableControlAction(2, 126, true)
			DisableControlAction(2, 127, true)
			DisableControlAction(2, 128, true)
			DisableControlAction(2, 280, true)
			DisableControlAction(2, 281, true)
			DisableControlAction(2, 340, true)
			DisableControlAction(2, 341, true)
			DisableControlAction(2, 343, true)
		end
		if Config.FoxWrecker == true and IsPlayerInHeavyWrecker() then
			if useboom == 0 and IsControlJustReleased(0, Config.EngageRotatorKey) then
				Wait(5000)
				SetCurrentPedVehicleWeapon(ped, -764006018)
				useboom = 1
			elseif useboom == 1 and IsControlJustReleased(0, Config.EngageRotatorKey) then
				SetCurrentPedWeapon(ped, -1569615261, false)
				useboom = 0
			end
		end
    end
end)

