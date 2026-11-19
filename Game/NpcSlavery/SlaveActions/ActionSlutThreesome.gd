extends SlaveActionBase

func _init():
	id = "ActionSlutThreesome"
	actionType = Action
	#extraSlaves = {}
	sceneID = "ActionSlutThreesomeScene"
	slaveResistChanceMult = 1.0
	
	slaveMinLevel = 0
	slaveSkillsRequired = {
		SlaveType.Slut: 5,
	}

	extraSlaves = {
		"sub2": {
			name = "Вторая рабыня",
			desc = "Кто будет вторым сабом в этом сексе?",
			slaveSkillsRequired = {
			},
			slaveMinLevel = 0,
		}
	}
	
	onlyShowWhenHaveRequiredSkills = true
	endsTalkScene = true
	
	buttonPriority = 70

func getVisibleName():
	return "Трио (2 подчиненные)"

func getVisibleDesc():
	return "Трахни сразу двух своих рабынь"

func fitsAsExtraSlaveAdvanced(_role, _charID):
#	if(_role == "dom"):
#		var npcSlave:NpcSlave = getSlave(_charID)
#		var theChar:BaseCharacter = npcSlave.getChar()
#		if(theChar.hasBoundArms() || theChar.hasBlockedHands() || theChar.isGagged() || theChar.hasBoundLegs()):
#			return [false, "Dominant has restraints on that prevent being able to do this"]
#
	return .fitsAsExtraSlaveAdvanced(_role, _charID)
