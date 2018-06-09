require("lua.events")

function ON_INIT()
	on_init()
end

function ON_CONFIGURATION_CHANGED(data)
	on_configuration_changed(data)
end	

function ON_TICK(event)
	on_tick(event)
end

function ON_TRAIN_CHANGED_STATE(event)
	on_train_changed_state(event)
end


script.on_init(ON_INIT)
script.on_configuration_changed(ON_CONFIGURATION_CHANGED)
script.on_event(defines.events.on_tick,ON_TICK)
script.on_event(defines.events.on_train_changed_state,ON_TRAIN_CHANGED_STATE)