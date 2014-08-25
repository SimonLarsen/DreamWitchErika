return {
	default = "fly",

	states = {
		["fly"] = { image = "wasp.png", fw = 20, fh = 20, delay = 0.08 },
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
