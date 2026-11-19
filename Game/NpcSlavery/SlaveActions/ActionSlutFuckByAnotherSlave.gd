extends SlaveActionBase

func _init():
	id = "ActionSlutFuckByAnotherSlave"
	actionType = Action
	#extraSlaves = {}
	sceneID = "ActionSlutFuckByAnotherSlaveScene"
	slaveResistChanceMult = 1.0
	
	slaveMinLevel = 0
	slaveSkillsRequired = {
		SlaveType.Slut: 2,
	}

	extraSlaves = {
		"dom": {
			name = "Доминант",
			desc = "Тот, кто трахнет твою шлюху",
			slaveSkillsRequired = {},
			slaveMinLevel = 0,
		}
	}
	
	onlyShowWhenHaveRequiredSkills = true
	endsTalkScene = true
	
	buttonPriority = 70

func getVisibleName():
	return "Раб над шлюхой"

func getVisibleDesc():
	return "Приказать одной из твоих шлюх принять в себя другого твоего раба"

func fitsAsExtraSlaveAdvanced(_role, _charID):
	if(_role == "dom"):
		var npcSlave:NpcSlave = getSlave(_charID)
		var theChar:BaseCharacter = npcSlave.getChar()
		if(theChar.hasBoundArms() || theChar.hasBlockedHands() || theChar.isGagged() || theChar.hasBoundLegs()):
			return [false, "У Доминанта надеты фиксаторы, которые не позволяют это сделать"]
	
	return .fitsAsExtraSlaveAdvanced(_role, _charID)
