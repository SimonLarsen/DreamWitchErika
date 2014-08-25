return {
	default = "idle",

	states = {
		["air"] = { image = "knight_air.png", fw = 20, fh = 20, delay = 0.1 },
		["die"] = { image = "knight_die.png", fw = 20, fh = 20, delay = 0.08, loop = false },
		["idle"] = { image = "knight_idle.png", fw = 20, fh = 20, delay = 0.13 },
		["run"] = { image = "knight_run.png", fw = 20, fh = 20, delay = 0.15 },
		["land"] = { image = "knight_land.png", fw = 20, fh = 20, delay = 0.1 },
		["jump"] = { image = "knight_jump.png", fw = 20, fh = 20, delay = 0.09 },
		["cooldown"] = { image = "knight_cooldown.png", fw = 20, fh = 20, delay = 0.15 },
	},

	properties = {
		["state"] = { value = 0 },
		["jump"] = { value = false, isTrigger = true },
		["die"] = { value = false, isTrigger = true },
		["land"] = { value = false, isTrigger = true },
	},

	transitions = {
		{
			from = "idle", to = "run",
			property = "state", value = 1
		},
		{
			from = "run", to = "jump",
			property = "jump", value = true
		},
		{
			from = "jump", to = "air",
			property = "_finished", value = true
		},
		{
			from = "any", to = "land",
			property = "land", value = true
		},
		{
			from = "land", to = "cooldown",
			property = "_finished", value = true
		},
		{
			from = "cooldown", to = "idle",
			property = "state", value = 0
		},
		{
			from = "any", to = "die",
			property = "die", value = true
		},
	},
}
