extends SlaveActionBase

func _init():
	id = "ActionChangeHaircut"
	actionType = Action
	#extraSlaves = {}
	sceneID = "ActionSlaveryHaircut"
	slaveResistChanceMult = 1.0
	
	slaveMinLevel = 3
	slaveSkillsRequired = {
	}
	
	buttonPriority = 100

func getVisibleName():
	return "Сменить прическу"

func getVisibleDesc():
	return "Загляни в ближайшую уборную и смени рабыне прическу"
