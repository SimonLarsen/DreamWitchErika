return {
	default = "run",

	states = {
		["idle"] = { image = "idle.png", fw = 20, fh = 20, delay = 0.15 },
		["run"] = { image = "run.png", fw = 20, fh = 20, delay = 0.15 },
	},

	properties = {
		["state"] = { value = 0 },
		-- 0: idle
		-- 1: run
	},

	transitions = {
		{
			from = "idle", to = "run",
			property = "state", value = 1
		},
		{
			from = "run", to = "idle",
			property = "state", value = 0
		}
	}
}
