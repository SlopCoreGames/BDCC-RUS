extends PlayerSlaveryDef

func _init():
	id = "ShaftMiner"

func getVisibleName() -> String:
	return "Шахтер шахты"

func getVisibleDesc() -> String:
	return "(Без сексуального подтекста) Тебя продадут мужику, который заставит тебя вкалывать в шахтах."

func canBeChosen() -> bool:
	return true

func createSlavery():
	return load("res://Game/PlayerSlavery/Scenarios/ShaftMiner.gd").new()

func getEndings() -> Dictionary:
	return {
		"mined": {
			name = "Ни один камень не останется неразработанным",
			desc = "Накопить нужную сумму кредитов",
		},
		"escaped": {
			name = "Супер-мега-бур",
			desc = "Найти способ сбежать вместе с другими рабами",
		},
		"killedboss": {
			name = "Просверленная до глубины души",
			desc = "Заставить этого ублюдка пожалеть о том, что он вообще к тебе полез",
		},
	}
