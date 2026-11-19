extends RestraintData
class_name RestraintBlindfold

func _init():
	npcDodgeDifficultyMod = 0.8
	restraintType = RestraintType.Blindfold
	sexReaction = SexReaction.BondageBlindfold

func canInspectWhileBlindfolded():
	return true

func canUnlockWithKey():
	return false
	
func alwaysSavedWhenStruggledOutOf():
	return true

func shouldDoStruggleMinigame(_pc):
	var _armsFree = !_pc.hasBoundArms()
	if(_armsFree):
		return false
	return .shouldDoStruggleMinigame(_pc)
	
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
		text = "{user.name} тщетно пытается сбросить повязку, но из-за неосторожных движений она [b]затягивается еще туже[/b] на {user.his} голове!"
		damage = -0.5
	elif(_handsFree && _armsFree):
		text = "Так как руки {user.name} свободны, {user.he} удается развязать {user.his} повязку."
		damage = 1.0
	elif(_handsFree):
		text = "Руки {user.name} свободны, но они связаны между собой, поэтому {user.name} приходится неуклюже наклоняться, чтобы дотянуться до повязки."
		damage = 1.0
		stamina = 5
	else:
		text = "{user.name} трясет {user.his} головой, пытаясь заставить повязку соскользнуть."
		damage = calcDamage(_pc, _minigame)
		stamina = 10
	
	#damage = calcDamage()
	
	return {"text": text, "damage": damage, "lust": lust, "pain": pain, "stamina": stamina}

func getResistAnimation():
	return "struggle_gag"

func getTightLockRequiredItemID() -> String:
	return "Shiv"

func getTightLockUnlockMessage() -> String:
	return "The lock is impossible to remove so you just cut through the thick cloth of the blindfold with a shiv until it falls apart."

func getForceOnCombatAnim() -> String:
	return "RestraintEyes"
