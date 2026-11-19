extends SlaveEventBase

func _init():
	id = "MindBreaks"
	eventWeight = 1.0

func canHappen(_npcSlavery:NpcSlave):
	if(_npcSlavery.isMindBroken()):
		return false
	if(_npcSlavery.getDespair() < 0.95): # Treat your slave well, yo
		return false
	return true

func shouldHappenChance(_npcSlavery:NpcSlave):
	return 33.3

func runEvent(_npcSlavery:NpcSlave):
	var theText = "С {npc.name} что-то не так. Что-то очень не так.."
	
	theText += "\n\nЧем дольше ты всматриваешься в глаза {npc.his}, тем более пустыми они кажутся.. Там ничего нет: ни гнева, ни радости.. там нет жизни.."
	
	theText += "\n\nКогда ты берешь и двигаешь руку {npc.his}, {npc.he} просто позволяет тебе придавать ей любую позу, какую пожелаешь. Словно кукла.."
	
	theText += "\n\nПохоже, какие бы пытки ты ни устраивал для {npc.him}, для бедной {npc.boy} это оказалось слишком. Ты сломал {npc.him}."

	_npcSlavery.doMindBreak()
	
	return {
		text = theText,
	}

func getAnimInfo(_npcSlavery:NpcSlave):
	return [StageScene.Duo, "stand", {npc=_npcSlavery.getChar().getID(), npcAction="stand"}]
