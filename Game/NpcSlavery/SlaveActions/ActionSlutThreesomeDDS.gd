extends SlaveActionBase

func _init():
	id = "ActionSlutThreesomeDDS"
	actionType = Action
	#extraSlaves = {}
	sceneID = "ActionSlutThreesomeDDSScene"
	slaveResistChanceMult = 1.0
	
	slaveMinLevel = 0
	slaveSkillsRequired = {
		SlaveType.Slut: 5,
	}

	extraSlaves = {
		"dom": {
			name = "Доминант",
			desc = "Кто станет вторым доминантом в этом сексе?",
			slaveSkillsRequired = {
			},
			slaveMinLevel = 0,
		}
	}
	
	onlyShowWhenHaveRequiredSkills = true
	endsTalkScene = true
	
	buttonPriority = 70

func getVisibleName():
	return "Тройничок (+доминант)"

func getVisibleDesc():
	return "Трахните свою рабыню вместе с одной из ваших других рабынь"

func fitsAsExtraSlaveAdvanced(_role, _charID):
	if(_role == "dom"):
		var npcSlave:NpcSlave = getSlave(_charID)
		var theChar:BaseCharacter = npcSlave.getChar()
		if(theChar.hasBoundArms() || theChar.hasBlockedHands() || theChar.isGagged() || theChar.hasBoundLegs()):
			return [false, "У Доминанта надеты фиксаторы, которые не позволяют это сделать"]

	return .fitsAsExtraSlaveAdvanced(_role, _charID)
