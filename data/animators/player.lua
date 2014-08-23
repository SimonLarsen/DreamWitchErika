return {
	default = "run",

	states = {
		["idle"] = { image = "idle.png", fw = 20, fh = 20, delay = 0.15 },
		["run"] = { image = "run.png", fw = 20, fh = 20, delay = 0.15 },
		["swing"] = { image = "swing.png", fw = 20, fh = 20, delay = 0.1 },
	},

	properties = {
		-- 0: idle
		-- 1: run
		["state"] = { value = 0 },
		["swing"] = { value = false, isTrigger = true },
	},

	transitions = {
		{
			from = "idle", to = "run",
			property = "state", value = 1
		},
		{
			from = "run", to = "idle",
			property = "state", value = 0
		},
		{
			from = "any", to = "swing",
			property = "swing", value = true
		},
		{
			from = "swing", to = "idle",
			property = "_finished", value = true
		}
	}
}
