extends PlayerSlaveryDef

func _init():
	id = "MilkCafe"

func getVisibleName() -> String:
	return "Рабыня-доярка"

func getVisibleDesc() -> String:
	return "Тебя продадут милой парочке, которая держит кафе, остро нуждающееся в молоке и/или семени."

func canBeChosen() -> bool:
	return true

func createSlavery():
	return load("res://Game/PlayerSlavery/Scenarios/MilkCafe.gd").new()

func getEndings() -> Dictionary:
	return {
		"earned": {
			name = "Выплатить долг",
			desc = "Быть послушной коровкой/бычком",
		},
		"annoyed": {
			name = "Купить тебя было ошибкой",
			desc = "Быть самой невыносимой тварью на свете",
		},
		"escaped": {
			name = "Командная работа — залог успеха",
			desc = "Сбежать с помощью других рабов",
		},
		"officer": {
			name = "Особое угощение",
			desc = "Привлечь внимание героя",
		},
	}
