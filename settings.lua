data:extend({
	{
		type = "bool-setting",
		name = "enable-speed-limit",
		setting_type = "runtime-global",
		default_value = true
	},
	{
		type = "int-setting",
		name = "max-train-speed-manual-mode",
		setting_type = "runtime-global",
		default_value = 20,
		minimum_value = 10
	}
})
