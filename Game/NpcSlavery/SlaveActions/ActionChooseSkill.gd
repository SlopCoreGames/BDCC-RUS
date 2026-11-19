extends SlaveActionBase

func _init():
	id = "ActionChooseSkill"
	actionType = Action
	#extraSlaves = {}
	sceneID = "ActionSlaveryChooseSkill"
	slaveResistChanceMult = 0.0
	
	slaveMinLevel = 5
	slaveSkillsRequired = {
	}
	
	buttonPriority = 110

func getVisibleName():
	return "Специализации"

func getVisibleDesc():
	return "Смените основную специализацию своей рабыни и заставьте её освоить новые навыки!"
