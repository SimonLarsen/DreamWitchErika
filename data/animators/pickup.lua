return {
	default = "idle",

	states = {
		["idle"] = { image = "pickup.png", fw = 40, fh = 40, delay = 0.2 },
		["taken"] = { image = "pickup_taken.png", fw = 40, fh = 40, delay = 0.2 }
	},

	properties = {
		["taken"] = { value = false, isTrigger = true },
	},

	transitions = {
		{
			from = "idle", to = "taken",
			property = "taken", value = true
		}
	},
}
