extends SlaveActionBase

func _init():
	id = "ActionSubSlaveHelper"
	actionType = Action
	#extraSlaves = {}
	sceneID = "ActionSlaverySubManageHelper"
	slaveResistChanceMult = 1.0
	
	slaveMinLevel = 0
	slaveSkillsRequired = {
		SlaveType.Submissive: 15,
	}
	onlyShowWhenHaveRequiredSkills = true
	
	buttonPriority = 40

func getVisibleName():
	return "Помощник рабыни"

func getVisibleDesc():
	return "Управление тем, как ваш саб будет помогать другим рабыням"

