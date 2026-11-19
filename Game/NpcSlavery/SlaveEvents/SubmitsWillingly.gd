extends SlaveEventBase

func _init():
	id = "SubmitsWillingly"
	eventWeight = 1.0

func canHappen(_npcSlavery:NpcSlave):
	if(_npcSlavery.hasSubmittedToPC()):
		return false
	if(_npcSlavery.getObedience() < 0.9):
		return false
	return true

func shouldHappenChance(_npcSlavery:NpcSlave):
	return 10.0 + clamp(_npcSlavery.getAwareness()-0.5, 0.0, 1.0) * 100.0

func runEvent(_npcSlavery:NpcSlave):
	var theText = "{npc.name} опускает {npc.his} взгляд, когда ты подходишь к {npc.him}. {npc.His} губы дрожат, {npc.he} явно хочет что-то сказать."

	theText += "\n\n[say=npc]"+RNG.pick([
		"Я... я хочу тебе кое-что сказать.",
		"Думаю, пришло время...",
		"Надеюсь, у тебя найдется минутка... Я хочу кое-что сказать...",
		"Можно мне кое-что тебе сказать...",
		"Есть минутка?.. Мне нужно кое-что сказать...",
	])+"[/say]\n\n"
	
	theText += "Весьма любопытно, ты киваешь... и наблюдаешь, как твоя рабыня медленно опускается на {npc.his} колени перед тобой, всё еще не поднимая {npc.his} взгляда."
	
	theText += "\n\n[say=npc]"+RNG.pick([
		"Спасибо, что обучили меня... И сделали моей... Я счастлива быть твоей рабыней... вечно...",
		"Я рада, что принадлежу тебе... Спасибо за обучение, я буду стараться слушаться изо всех сил...",
		"Ты моя... Навсегда и навечно. Спасибо, что обучили меня... Я буду стараться изо всех сил, будучи твоей рабыней...",
	])+"[/say]\n\n"
	
	theText += "Ты не можешь сдержать улыбку — твоя рабыня только что добровольно покорилась тебе! {npc.He} медленно поднимает глаза, и в {npc.his} взгляде читается абсолютная покорность. Ты ласково гладишь {npc.him} по голове и чувствуешь, как {npc.him} ластится к твоей руке."
	
	theText += "\n\nЭто значит, что {npc.his} послушание, любовь и сломленный дух больше не будут увядать."
	
	_npcSlavery.doSubmitToPC()
	
	_npcSlavery.deservesReward(4)
	
	return {
		text = theText,
	}

func getAnimInfo(_npcSlavery:NpcSlave):
	return [StageScene.Duo, "stand", {npc=_npcSlavery.getChar().getID(), npcAction="kneel"}]
