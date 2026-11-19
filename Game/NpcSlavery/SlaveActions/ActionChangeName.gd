extends SlaveActionBase

func _init():
	id = "ActionChangeName"
	actionType = Action
	#extraSlaves = {}
	sceneID = "ActionSlaveryChangeName"
	slaveResistChanceMult = 1.0
	
	slaveMinLevel = 7
	slaveSkillsRequired = {
	}
	
	buttonPriority = 30

func getVisibleName():
	return "Изменить имя"

func getVisibleDesc():
	return "Дайте своей рабыне новое имя"
