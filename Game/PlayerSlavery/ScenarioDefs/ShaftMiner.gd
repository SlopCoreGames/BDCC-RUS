extends PlayerSlaveryDef

func _init():
	id = "ShaftMiner"

func getVisibleName() -> String:
	return "Шахтер шахты"

func getVisibleDesc() -> String:
	return "(Non-sexual focus) You will be sold to a guy who will force you to become a shaft miner."

func canBeChosen() -> bool:
	return true

func createSlavery():
	return load("res://Game/PlayerSlavery/Scenarios/ShaftMiner.gd").new()

func getEndings() -> Dictionary:
	return {
		"mined": {
			name = "Ни один камень не останется неразработанным",
			desc = "Reach the required amount of credits",
		},
		"escaped": {
			name = "Супер-мега-бур",
			desc = "Find a way to escape together with other slaves",
		},
		"killedboss": {
			name = "Просверленная до глубины души",
			desc = "Make the guy regret ever messing with you",
		},
	}
