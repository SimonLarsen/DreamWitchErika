return {
	default = "idle",

	states = {
		["idle"] = { image = "slime_idle.png", fw = 20, fh = 20, delay = 0.15 },
		["die"] = { image = "slime_die.png", fw = 20, fh = 20, delay = 0.1, loop = false },
	},

	properties = {
		["die"] = { value = false, isTrigger = true },
	},

	transitions = {
		{
			from = "any", to = "die",
			property = "die", value = true
		},
	},
}
