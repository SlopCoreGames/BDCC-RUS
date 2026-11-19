extends SlaveEventBase

func _init():
	id = "SubmitsUnwillingly"
	eventWeight = 1.0

func canHappen(_npcSlavery:NpcSlave):
	if(_npcSlavery.hasSubmittedToPC()):
		return false
	if(_npcSlavery.getBrokenSpirit() < 0.9):
		return false
	return true

func shouldHappenChance(_npcSlavery:NpcSlave):
	return 10.0 + min(0.5, _npcSlavery.getDespair()) * 100.0

func runEvent(_npcSlavery:NpcSlave):
	var theText = "В {npc.name} есть что-то необычное. Стоит тебе подойти к {npc.him}, как {npc.he} начинает дрожать."

	theText += "\n\n[say=npc]"+RNG.pick([
		"Я не могу... Да к черту всё...",
		"Ладно... Ты победил, ясно?",
		"Listen, you..",
		"Я не могу...",
		"Можешь остановиться... ты победил.",
		"Я сдаюсь...",
		"Я... я больше не могу... я сдаюсь...",
		"Ты заставил меня...",
		"Ненавижу тебя... Но...",
	])+"[/say]\n\n"
	
	theText += "После этого {npc.he} падает перед тобой на {npc.his} колени, а в глазах {npc.his} читается полное отчаяние."
	
	theText += "\n\n[say=npc]"+RNG.pick([
		"Я... сдаюсь.",
		"Теперь я твоя, ладно? Я так устала от... всего этого...",
		"Я подчиняюсь... Буду делать всё, что ты скажешь...",
		"Я сделаю всё что угодно... Я сдаюсь...",
	])+"[/say]\n\n"
	
	theText += "Ты не можешь сдержать улыбку: похоже, ты сломал свою рабыню достаточно сильно, чтобы {npc.him} наконец-то покорилась тебе."
	
	theText += "\n\nЭто значит, что {npc.his} послушание, любовь и сломленный дух больше не будут увядать."
	
	_npcSlavery.doSubmitToPC()
	
	_npcSlavery.deservesReward(3)
	
	return {
		text = theText,
	}

func getAnimInfo(_npcSlavery:NpcSlave):
	return [StageScene.Duo, "stand", {npc=_npcSlavery.getChar().getID(), npcAction="kneel"}]
