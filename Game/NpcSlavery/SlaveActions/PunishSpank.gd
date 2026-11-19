extends SlaveActionBase

func _init():
	id = "PunishSpank"
	actionType = Punishment
	#extraSlaves = {}
	#sceneID = "MeScene"
	#endsTalkScene = true
	slaveResistChanceMult = 1.0
	slaveOnlyActiveResist = true
	
	buttonPriority = 80
	rewardHint = -2

func getVisibleName():
	return "Отшлепать"

func getVisibleDesc():
	return "Хорошенько отшлепать свою рабыню"

func doActionSimple(_slaveID, _extraSlavesIDs = {}):
	var npcSlavery:NpcSlave = getSlave(_slaveID)
	
	var text = "Раздраженный своим рабом, вы ставите {npc.him} на четвереньки и наносите серию крепких шлепков по {npc.his} {npc.thick} заднице!\n\n"
	
	if(npcSlavery.getSpoiling() > 0.7):
		text += "{npc.He} ахает и громко жалуется, пытаясь прикрыть {npc.his} задницу {npc.his} руками... но в итоге они тоже получают по щелбану."
	elif(npcSlavery.isActivelyResisting()):
		text += "Каждый шлепок сопровождается активным сопротивлением: {npc.heShe} пытается увернуться от наказания. Несмотря на то, что {npc.he} изо всех {npc.isAre} старается отбиваться, вам всё же удается нанести несколько ощутимых ударов."
	elif(npcSlavery.getFear() > 0.6 && npcSlavery.personalityScore({PersonalityStat.Coward: 1.0}) > 0.1):
		text += "Страх застилает глаза {npc.his} с каждым шлепком, делая {npc.him} покорной, но тревожной; {npc.heShe} заметно дрожит после каждого удара."
	elif(npcSlavery.rewardBalance >= 0):
		text += "Каждый шлепок сопровождается звуками замешательства и разочарования; {npc.name} изо всех {npc.his} сил старается вытерпеть это несправедливое наказание."
	elif(npcSlavery.getObedience() > 0.5 || npcSlavery.getLove() > 0.5 || npcSlavery.getBrokenSpirit() > 0.5):
		text += "{npc.HeShe} покорно подчиняется, принимая каждый шлепок с тихим смирением. Глаза опущены, задница высоко торчит, и каждый удар заставляет {npc.him} издавать сдавленный звук."
	else:
		text += "Каждый шлепок сопровождается сдавленным рычанием, {npc.name} неудобно ерзает. Надеемся, это станет хорошим уроком для {npc.him}."
	
	text += "\n\nК концу наказания задница {npc.his} приобретает приятный теплый красный оттенок."
	
	npcSlavery.handlePunishment(2)
	return {
		text = text,
	}

func getAnimationInfo(_slaveID, _extraSlavesIDs = {}):
	return [StageScene.Spanking, "spankonce", {pc="pc", npc=_slaveID}]
