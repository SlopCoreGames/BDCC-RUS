extends SlaveEventBase

func _init():
	id = "SubmitsOutOfNeediness"
	eventWeight = 1.0

func canHappen(_npcSlavery:NpcSlave):
	if(_npcSlavery.hasSubmittedToPC()):
		return false
	if(_npcSlavery.getNeediness() < 80.0):
		return false
	return true

func shouldHappenChance(_npcSlavery:NpcSlave):
	return 10.0 + clamp(_npcSlavery.getLove(), 0.0, 1.0) * 100.0

func runEvent(_npcSlavery:NpcSlave):
	var theText = "{npc.name} начинает дрожать, когда ты подходишь к {npc.him}. Губы {npc.His} трепещут, {npc.he} явно хочет что-то сказать."

	theText += "\n\n[say=npc]"+RNG.pick([
		"Я больше не могу.. блядь, больше не могу.. Я сдаюсь.. Ты победил..",
	])+"[/say]\n\n"
	
	theText += "Очень интересно.. ты наблюдаешь, как твоя рабыня медленно опускается на {npc.his} колени перед тобой, а в глазах {npc.his} читается запредельное вожделение."
	
	theText += "\n\n[say=npc]"+RNG.pick([
		"ПОЖАЛУЙСТА! ТРАХНИ МЕНЯ! ДАЙ МНЕ КОНЧИТЬ! Я СДЕЛАЮ ВСЁ ЧТО УГОДНО! РЕАЛЬНО ВСЁ.. Я просто хочу кончить.. Буду твоей сучкой.. Сделаю всё.. Всё, что захочешь.. По-о-ожалуйста.. Ну пожалуйста, трахни меня.. ну же..",
	])+"[/say]\n\n"
	
	theText += "Ты не можешь сдержать улыбку — твоя рабыня только что покорилась тебе! Кто бы мог подумать, что если так долго держать кого-то в состоянии сексуального голода, это приведет к такому шикарному результату."
	
	theText += "\n\nЭто значит, что {npc.his} послушание, любовь и сломленный дух больше не будут увядать."
	
	_npcSlavery.doSubmitToPC()
	
	_npcSlavery.deservesReward(4)
	
	return {
		text = theText,
	}

func getAnimInfo(_npcSlavery:NpcSlave):
	return [StageScene.Duo, "stand", {npc=_npcSlavery.getChar().getID(), npcAction="kneel"}]
