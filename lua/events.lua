require("lua.lib")
MODNAME = "ManualSpeedLimit"


local function Init()
	global.SpeedLimit = global.SpeedLimit or {}
	global.SpeedLimit.TrainList = global.SpeedLimit.TrainList or {}
end

local function Migration(data)
	if NeedMigration(data,MODNAME) then
		local old_version = GetOldVersion(data,MODNAME)
		if old_version < "00.00.00" then
		
		
		end
	end
end

local function CalcTrainSpeed(direction,speed)
	local max_speed = settings.global['max-train-speed-manual-mode'].value / 216
	local decel = 0.01
	local abs_speed = math.abs(speed)
	
	if abs_speed > max_speed + 0.05 then
		if direction == "forwards" then
			return speed - decel
		elseif direction == "backwards" then
			return speed + decel
		end
	else
		if direction == "forwards" then
			return math.min(speed,max_speed)
		elseif direction == "backwards" then
			return math.max(speed,-max_speed)
		end
	end
end


local function Tick(event)
	if not settings.global['enable-speed-limit'].value then return end
	--if event.tick % 5 ~= 3 then return end
	if #global.SpeedLimit.TrainList == 0 then return end
	for i,train in pairs(global.SpeedLimit.TrainList) do
		if not (train and train.valid and train.manual_mode) then 
			table.remove(global.SpeedLimit.TrainList,i)
			goto continue
		end
		if train.speed > 0 then
			train.speed = CalcTrainSpeed("forwards",train.speed)
		elseif train.speed < 0 then
			train.speed = CalcTrainSpeed("backwards",train.speed)
		end
		::continue::
	end
end

local function OnTrainChangedState(event)
	local train = event.train
	if train.state == defines.train_state.manual_control then
		table.insert(global.SpeedLimit.TrainList,train)
	end
end








function on_init()
	Init()
end

function on_configuration_changed(data)
	Init()
	--Migration(data)
end	

function on_tick(event)
	Tick(event)
end

function on_train_changed_state(event)
	OnTrainChangedState(event)
end