extends SlaveEventBase

func _init():
	id = "SlaveEscapes"
	eventWeight = 1.0

func canHappen(_npcSlavery:NpcSlave):
	if(_npcSlavery.isMindBroken()):
		return false
	if(_npcSlavery.getChar().getInventory().hasRemovableRestraints()):
		return false
	return true

func shouldHappenChance(_npcSlavery:NpcSlave):
	return _npcSlavery.getUnhappinessEscapeChance()

func runEvent(_npcSlavery:NpcSlave):
	var theText = "Ты оглядываешься по сторонам... и понимаешь, что одна из твоих рабынь исчезла!"

	var slaveName = _npcSlavery.getChar().getName()
	theText += "\n\n"+slaveName+" её здесь нет. Всё, что осталось... обрывок цепи на полу. Может, наличие каких-нибудь оков помогло бы избежать такого? Или, может, тебе стоит относиться к своим рабыням чуть лучше? Да нет, глупости какие."
	
	theText += "\n\nТы можешь попытаться найти и снова поработить её. Или позволить кому-то другому занять её место. Но пока что у тебя на одну рабыню меньше."

	var slaveID:String = _npcSlavery.getChar().getID()
	GlobalRegistry.getModule("NpcSlaveryModule").doFreeEnslavedCharacter(slaveID)
	GM.pc.getReputation().addRep(RepStat.Alpha, -3.0)
	GM.main.RS.sendSocialEvent("pc", slaveID, SocialEventType.EscapedSlavery)
	
	return {
		text = theText,
	}

func getAnimInfo(_npcSlavery:NpcSlave):
	return [StageScene.Solo, "stand", {}]

func onEventSkipped(_npcSlavery:NpcSlave):
	var slaveID:String = _npcSlavery.getChar().getID()
	GlobalRegistry.getModule("NpcSlaveryModule").doFreeEnslavedCharacter(slaveID)
	GM.main.addLogMessage("Ох, ну да ладно", "Похоже, одному из твоих рабов удалось сбежать. Может, попробуешь выследить его?")
	GM.pc.getReputation().addRep(RepStat.Alpha, -3.0)
	GM.main.RS.sendSocialEvent("pc", slaveID, SocialEventType.EscapedSlavery)
