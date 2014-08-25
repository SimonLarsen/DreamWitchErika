return {
	default = "run",

	states = {
		["idle"] = { image = "idle.png", fw = 20, fh = 20, delay = 0.15 },
		["run"] = { image = "run.png", fw = 20, fh = 20, delay = 0.12 },
		["swing"] = { image = "swing.png", fw = 20, fh = 20, delay = 0.1 },
		["superswing"] = { image = "superswing.png", fw = 20, fh = 20, delay = 0.08 },
		["jump"] = { image = "jump.png", fw = 20, fh = 20, delay = 0.08 },
		["fly"] = { image = "fly.png", fw = 20, fh = 20, delay = 0.1 },
		["land"] = { image = "land.png", fw = 20, fh = 20, delay = 0.08 },
		["dash"] = { image = "dash.png", fw = 20, fh = 20, delay = 0.1 },
		["stunned"] = { image = "stunned.png", fw = 20, fh = 20, delay = 0.1 },
		["powerupget"] = { image = "powerupget.png", fw = 20, fh = 20, delay = 0.13 },
	},

	properties = {
		-- 0: idle
		-- 1: run
		-- 2: fly
		-- 3: stunned
		["state"] = { value = 0 },
		["swing"] = { value = false, isTrigger = true },
		["superswing"] = { value = false, isTrigger = true },
		["jump"] = { value = false, isTrigger = true },
		["dash"] = { value = false, isTrigger = true },
		["powerupget"] = { value = false, isTrigger = true },
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
		},
		{
			from = "any", to = "superswing",
			property = "superswing", value = true
		},
		{
			from = "superswing", to = "idle",
			property = "_finished", value = true
		},
		{
			from = "any", to = "jump",
			property = "jump", value = true
		},
		{
			from = "any", to = "dash",
			property = "dash", value = true
		},
		{
			from = "dash", to = "fly",
			property = "_finished", value = true
		},
		{
			from = "jump", to = "fly",
			property = "_finished", value = true
		},
		{
			from = "run", to = "fly",
			property = "state", value = 2
		},
		{
			from = "fly", to = "land",
			property = "state", value = 0
		},
		{
			from = "fly", to = "land",
			property = "state", value = 1
		},
		{
			from = "land", to = "idle",
			property = "_finished", value = true
		},
		{
			from = "any", to = "stunned",
			property = "state", value = 3
		},
		{
			from = "stunned", to = "fly",
			property = "_finished", value = true
		},
		{
			from = "any", to = "powerupget",
			property = "powerupget", value = true
		},
		{
			from = "powerupget", to = "fly",
			property = "_finished", value = true
		},
	}
}
