extends StatusEffectBase

func _init():
	id = "SexSpacedOutMindbroken"
	isSexEngineOnly = true
	alwaysCheckedForNPCs = true
	
func shouldApplyTo(_npc):
	if(GM.main != null && GM.main.supportsSexEngine()):
		if(_npc.isSlaveToPlayer()):
			var npcSlave:NpcSlave = _npc.getNpcSlavery()
			if(npcSlave.isMindBroken()):
				return true
	return false
	
func initArgs(_args = []):
	pass
	
func processBattleTurn():
	pass
	
func processTime(_minutesPassed: int):
	pass

func getEffectName():
	return "Рассеянность"

func getEffectDesc():
	return "Твой разум где-то далеко, ты совершенно ничего не можешь делать."

func getEffectImage():
	return "res://Images/StatusEffects/hypnosis.png"

func getIconColor():
	return IconColorGray

func combine(_args = []):
	pass

func getBuffs():
	return [
		buff(Buff.SpacedOutInSexBuff, [100])
	]
