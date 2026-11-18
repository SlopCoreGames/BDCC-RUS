extends PlayerSlaveryDef

func _init():
	id = "Tentacles"

func getVisibleName() -> String:
	return "Тентакли"

func getVisibleDesc() -> String:
	return "You will help grow your very own tentacle monster."

func canBeChosen() -> bool:
	return true

func isVisibleAtAll() -> bool:
	return true

func createSlavery():
	return load("res://Game/PlayerSlavery/Scenarios/Tentacles.gd").new()

func getEndings() -> Dictionary:
	return {
		"murder": {
			name = "BLOODTHIRSTY",
			desc = "Escape while murdering at least one of the villains",
		},
		"stealth": {
			name = "Целый новый мир",
			desc = "Escape the biolab completely stealthily",
		},
		"egged": {
			name = "Прощальный подарок",
			desc = "Escape while getting at least one of the villains egged-up",
		},
	}
