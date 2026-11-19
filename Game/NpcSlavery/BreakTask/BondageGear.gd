extends NpcBreakTaskBase

var didForce = []

func _init():
	id = "BondageGear"

func getSlaveTypeWeights(_isSlaveLevelup):
	return {
		SlaveType.Submissive : 1.0,
		SlaveType.All : 0.6,
	}

func getNpcOwnerWeight(_npcOwner) -> float:
	return 0.2

func isPossibleFor(_npc, _isSlaveLevelup):
	if(_npc.getInventory().getEquppedRemovableRestraints().size() >= 3):
		return false
	return true

func isPossibleForPC(_pc, _npc, _isSlaveLevelup):
	if(_pc.getInventory().getAllCombatUsableRestraints().size() < 3):
		return false
	return true

func generateFor(_npc, _isSlaveLevelup, _difficulty = 1.0):
	needAmount = Util.mini(3, scaledRangeWithDifficulty(1, 2, _difficulty/2.0))

func onSexEvent(_npc, _event:SexEvent):
	if(_event.getType() == SexEvent.BondageGearForced):
		if(_event.getTargetChar() == _npc):
			var itemID = _event.getField("itemID", "someitem")
			if(!didForce.has(itemID)): # Protection against putting the same restraints on the same npc
				didForce.append(itemID)
				advanceTask()
				return true
	return false

func getTaskString():
	return "Надеть БДСМ-атрибутику на: "+getProgressString()

func getTaskStringSlutLock():
	return "Затянуть в БДСМ-атрибутику: "+getProgressString()

func getTaskHint(_isSlaveLevelup):
	return "Использовать разные виды фиксации во время секса. Если места нет, сначала что-нибудь сними."

func getNpcOwnerDialogueLines() -> Array:
	return [
		"Хочу, чтобы во время следующего траха ты была закована в снаряжение. Не стесняйся.",
		"Твой следующий партнер должен использовать на тебе игрушки. Закуйся во что-нибудь.",
		"Ты выглядишь лучше всего, когда тебя сдерживают. Иди надень что-нибудь для бондажа.",
		"Найди кого-нибудь, кто хорошенько тебя свяжет, прежде чем начнет использовать.",
		"Нацепи на себя БДСМ-атрибутику.",
	]

func getSexGoalWeightModifier(_sexGoalID:String) -> float:
	if(_sexGoalID == SexGoal.TieUp):
		return 3.0
	return 0.0

func saveData():
	var data = .saveData()
	data["didForce"] = didForce
	
	return data

func loadData(data):
	.loadData(data)
	
	didForce = SAVE.loadVar(data, "didForce", [])
