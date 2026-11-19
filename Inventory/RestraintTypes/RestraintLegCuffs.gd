extends RestraintData
class_name RestraintLegCuffs

var tightlockShiv:bool = false

func _init():
	npcDodgeDifficultyMod = 1.1
	restraintType = RestraintType.AnkleCuffs
	sexReaction = SexReaction.BondageAnkleCuffs

func doStruggle(_pc, _minigame:MinigameResult):
	var _handsFree = !_pc.hasBlockedHands()
	var _armsFree = !_pc.hasBoundArms()
	var _legsFree = !_pc.hasBoundLegs()
	var _canSee = !_pc.isBlindfolded()
	var _canBite = !_pc.isBitingBlocked()
	
	var text = "ошибка?"
	var lust = 0
	var pain = 0
	var damage = 0
	var stamina = 0
	
	if(failChanceLowScore(_pc, 15, _minigame)):
		text = "{user.name} пинает и крутит {user.his} ногами, пытаясь освободить {user.his} лодыжки из кандалов. Чем сильнее {user.he} извивается, тем [b]туже затягиваются кандалы[/b]."
		damage = -0.5
	elif(_handsFree && _armsFree):
		text = "{user.name} использует {user.his} руки, пытаясь снять ножные кандалы."
		damage = calcDamage(_pc, _minigame)
		stamina = 10
	else:
		text = "{user.name} катается по полу, беспомощно пытаясь стряхнуть {user.his} ножные кандалы."
		damage = calcDamage(_pc, _minigame, 0.5)
		stamina = 10
		
		if(failChance(_pc, 10)):
			text += " Ow! {user.name} accidently smashed them against "+RNG.pick(["the wall", "the ground", "something"])
			pain = scaleDamage(RNG.randi_range(5, 10))
	
	#damage = calcDamage()
	
	return {"text": text, "damage": damage, "lust": lust, "pain": pain, "stamina": stamina}

func getResistAnimation():
	return "struggle_legs"

func getTightLockRequiredItemID() -> String:
	if(tightlockShiv):
		return "Shiv"
	return .getTightLockRequiredItemID()

func getTightLockUnlockMessage() -> String:
	if(tightlockShiv):
		return "The lock is impossible to remove so you just use a shiv to cut through the restraint, slowly freeing your ankles."
	return .getTightLockUnlockMessage()

func getForceOnCombatAnim() -> String:
	return "RestraintLegs"
