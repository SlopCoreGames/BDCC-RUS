extends PlayerSlaveryDef

func _init():
	id = "Tentacles"

func getVisibleName() -> String:
	return "Тентакли"

func getVisibleDesc() -> String:
	return "Вы будете помогать выращивать собственного монстра с щупальцами."

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
			desc = "Сбежать, прикончив как минимум одного из злодеев.",
		},
		"stealth": {
			name = "Целый новый мир",
			desc = "Сбежать из биолаборатории абсолютно скрытно.",
		},
		"egged": {
			name = "Прощальный подарок",
			desc = "Сбежать, успев засадить хотя бы в одного из злодеев яйцо.",
		},
	}
