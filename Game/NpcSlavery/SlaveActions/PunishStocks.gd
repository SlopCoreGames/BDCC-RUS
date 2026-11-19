extends SlaveActionBase

func _init():
	id = "PunishStocks"
	actionType = Punishment
	#extraSlaves = {}
	#sceneID = "MeScene"
	#endsTalkScene = true
	slaveResistChanceMult = 1.0
	slaveOnlyActiveResist = true
	
	buttonPriority = 70
	rewardHint = -3

func getVisibleName():
	return "Колодки"

func getVisibleDesc():
	return "Посадить рабыню в колодки и посмотреть, как ей это понравится"

func doActionSimple(_slaveID, _extraSlavesIDs = {}):
	var npcSlavery:NpcSlave = getSlave(_slaveID)
	
	var text = "Жаждущий наказания, вы накидываете поводок на {npc.name} и приводите {npc.him} к главной платформе для наказаний. Найдя свободные колодки, вы с силой зашвыриваете в них свою рабыню, при необходимости не жалея напора."
	
	text += "\n\nВы следите за тем, чтобы голова и руки {npc.his} были надежно зафиксированы, и просто позволяете {npc.him} «наслаждаться» тем, что её заставили принять столь уязвимую и открытую позу примерно на полчаса.\n\n"
	
	if(npcSlavery.getSpoiling() > 0.7):
		text += "Ваша рабыня ни капли не в восторге: {npc.he} сверлит вас взглядом своих {npc.his} избалованных глаз, явно ожидая, что вы освободите {npc.him} прямо сейчас. К счастью, вы вовсе не обязаны подчиняться."
	
	elif(npcSlavery.isActivelyResisting()):
		text += "Ваша рабыня явно не в восторге от происходящего: {npc.he} изо всех сил пытается вырваться из металлических колодок, но те оказываются достаточно прочными, оставляя {npc.him} лишь в состоянии полного изнеможения."
	elif(npcSlavery.getFear() > 0.6 && npcSlavery.personalityScore({PersonalityStat.Coward: 1.0}) > 0.1):
		text += "До этого ваша рабыня была напугана, но теперь {npc.he} {npc.isAre} практически дрожит; стыд от такого положения в сочетании с невозможностью оглянуться назад делает {npc.him} весьма... послушной."
		npcSlavery.addObedience(0.05)
	elif(npcSlavery.rewardBalance >= 0):
		text += "На лице вашей рабыни читаются замешательство и разочарование, когда вы подвергаете {npc.him} этому несправедливому наказанию."
	else:
		text += "Ваша рабыня подчиняется, даже если это устройство доставляет {npc.him} сильнейший дискомфорт. Но для этого наказания и существуют."
	
	npcSlavery.handlePunishment(3)
	npcSlavery.addTired(0.5)
	return {
		text = text,
	}

func getAnimationInfo(_slaveID, _extraSlavesIDs = {}):
	return [StageScene.StocksSexOral, "tease", {npc="pc", pc=_slaveID}]

func getActionLocation(_slaveID, _extraSlavesIDs = {}):
	return "main_punishment_spot"

func getTimePass(_slaveID, _extraSlavesIDs = {}):
	return 60*30

func getExtraActions(_slaveID, _extraSlavesIDs = {}):
	return [
		{
			name = "Запереть в колодки",
			desc = "Оставить рабыню в колодках",
			sceneID = "PunishSlaveryLeaveInStocks",
			args = [],
			buttonChecks = [],
		}
	]
