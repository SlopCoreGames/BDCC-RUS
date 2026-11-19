extends SlaveEventBase

func _init():
	id = "SubmitsOutOfLove"
	eventWeight = 1.0

func canHappen(_npcSlavery:NpcSlave):
	if(_npcSlavery.hasSubmittedToPC()):
		return false
	if(_npcSlavery.getLove() < 0.9):
		return false
	return true

func shouldHappenChance(_npcSlavery:NpcSlave):
	return 10.0 + clamp(_npcSlavery.getTrust()-0.5, 0.0, 1.0) * 100.0

func runEvent(_npcSlavery:NpcSlave):
	var theText = "{npc.name} слегка опускает взгляд, когда ты подходишь; {npc.his} губы {npc.his} остаются слегка приоткрытыми, пока {npc.he} {npc.isAre} набирается смелости."

	theText += "\n\n[say=npc]"+RNG.pick([
		"Я давно... хотела... признаться тебе в чувствах...",
		"Моё сердце переполнено чувствами, и мне нужно ими с тобой поделиться.",
		"Надеюсь, у тебя найдется минутка... Я хочу кое-что сказать...",
		"Можно мне кое в чем признаться? Это насчет... моих чувств к тебе...",
		"Я... я хочу тебе кое-что сказать... Это насчет нас...",
	])+"[/say]\n\n"
	
	theText += "С теплой улыбкой вы подбадриваете {npc.him} заговорить, чувствуя нежность в голосе {npc.his}."
	
	theText += "\n\n[say=npc]"+RNG.pick([
		"Я глубоко люблю тебя, и принадлежать тебе — моя величайшая радость... Надеюсь, так будет всегда...",
		"Ты для меня — весь мир. Я люблю тебя всем сердцем...",
		"Спасибо, что ты есть в моей жизни. Спасибо, что сделал(а) меня своим (своей)... Я так сильно тебя люблю...",
		"Мне так повезло принадлежать тебе. Я люблю тебя бесконечно...",
		"Быть твоей рабыней — это привилегия, потому что я люблю тебя... безусловно...",
	])+"[/say]\n\n"
	
	theText += "Затронутый искренними словами {npc.his}, вы не можете удержаться, чтобы не обнять {npc.him}, и чувствуете, как {npc.him} делает то же самое. Трудно поверить, но ваша рабыня покорилась вам из любви!"
	
	theText += "\n\nЭто значит, что {npc.his} послушание, любовь и сломленный дух больше не будут увядать."
	
	_npcSlavery.doSubmitToPC()
	
	_npcSlavery.deservesReward(4)
	
	return {
		text = theText,
	}

func getAnimInfo(_npcSlavery:NpcSlave):
	return [StageScene.Hug, "hug", {npc=_npcSlavery.getChar().getID()}]
