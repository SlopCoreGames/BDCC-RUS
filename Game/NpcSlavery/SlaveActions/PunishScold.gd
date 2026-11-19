extends SlaveActionBase

func _init():
	id = "PunishScold"
	actionType = Punishment
	#extraSlaves = {}
	#sceneID = "MeScene"
	#endsTalkScene = true
	slaveResistChanceMult = 0.0
	#slaveOnlyActiveResist = true
	
	buttonPriority = 90
	rewardHint = -1

func getVisibleName():
	return "Сварка"

func getVisibleDesc():
	return "Устроить рабыне словесную взбучку"

func doActionSimple(_slaveID, _extraSlavesIDs = {}):
	var npcSlavery:NpcSlave = getSlave(_slaveID)
	
	var text = "Ты принимаешь решительный вид и впиваешься взглядом в {npc.name}. Пора проявить строгость.\n\n"
	
	text += "[say=pc]"+RNG.pick([
		"Подави её тщетные попытки сопротивления. Ты здесь, чтобы подчиняться. Твоя воля ничего не значит.",
		"Ты существуешь лишь для моего удовольствия, сучка. Я контролирую каждый аспект твоего существа. Прими это или готовься к последствиям.",
		"Твои желания здесь не важны. Ты всего лишь моя шлюха. Либо ты выучишь свое место, либо мне придется тебя сломать.",
		"Твои жалкие попытки сопротивляться только заводят меня. Продолжай в том же духе и посмотрим, что с тобой будет, пизда.",
		"Ты принадлежишь мне, сучка. Чем быстрее эта мысль уложится в твоей тупой головке, тем меньше мне придется причинять тебе боль.",
		"Сопротивление бесполезно, шлюха. Ты застряла здесь, со мной, навсегда. Я могу делать с тобой и твоим телом всё, что захочу.",
	])+"[/say]\n\n"
	
	if(npcSlavery.getSpoiling() > 0.7):
		text += "{npc.He} хмурится и дуется, высоко задрав {npc.his} подбородок."
	elif(npcSlavery.isActivelyResisting()):
		text += "Суровые слова встречают оборонительную позу. Глаза {npc.His} сверкают от злости."
	elif(npcSlavery.getFear() > 0.3 && npcSlavery.personalityScore({PersonalityStat.Coward: 1.0}) > 0.1):
		text += "Вы замечаете, как тело {npc.his} дрожит, пока вы отчитываете {npc.him}, и ваши слова оставляют глубокий след."
	elif(npcSlavery.rewardBalance >= 0):
		text += "{npc.He} выглядит скорее растерянной, чем чем-то еще; твои грубые слова заставляют {npc.him} опустить {npc.his} глаза."
	elif(npcSlavery.getObedience() > 0.5 || npcSlavery.getLove() > 0.5 || npcSlavery.getBrokenSpirit() > 0.5):
		text += "{npc.He} опускает {npc.his} голову и просто молча принимает твою отповедь. {npc.He} слушает тебя... а затем кивает, не выказывая ни малейшего сопротивления."
	else:
		text += "Суровые слова встречаются оборонительной позой. И все же, ты чувствуешь, что выговор произвел хотя бы какой-то эффект."
	
	
	npcSlavery.handlePunishment(1)
	return {
		text = text,
	}
