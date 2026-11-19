extends SlaveActionBase

func _init():
	id = "ActionSubShowerPC"
	actionType = Action
	#extraSlaves = {}
	sceneID = "ActionSlaveryShower"
	slaveResistChanceMult = 1.0
	
	slaveMinLevel = 0
	slaveSkillsRequired = {
		SlaveType.Submissive: 4,
	}
	onlyShowWhenHaveRequiredSkills = true
	
	buttonPriority = 90

func getVisibleName():
	return "Душ"

func getVisibleDesc():
	return "Прикажи своему сабу омыть тебя в душе"

