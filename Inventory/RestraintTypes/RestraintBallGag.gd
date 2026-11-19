extends RestraintData
class_name RestraintBallGag

func _init():
	restraintType = RestraintType.Gag
	sexReaction = SexReaction.BondageGag

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
		text = "{user.name} изо всех сил пытается вытолкнуть шарик-кляп изо рта {user.his}, но от {user.his} лихорадочных движений он лишь [b] сильнее вжимается в {user.his} зубы и язык[/b], еще эффективнее заглушая {user.his} протесты."
		damage = -0.5
	elif(_handsFree && _armsFree):
		text = "{user.name} тянет за ремни налобной портупеи {user.his}, пытаясь снять её."
		damage = calcDamage(_pc, _minigame)
		stamina = 10
	else:
		text = "{user.name} пытается вцепиться зубами в шарик во рту {user.his}, но из-за резины это чертовски трудно."
		damage = calcDamage(_pc, _minigame, 0.1)
		stamina = 5
	
	if(failChance(_pc, 20)):
		text += " The ball in {user.his} mouth makes {user.him} drool a lot."
		lust = scaleDamage(5)
	
	#damage = calcDamage()
	
	return {"text": text, "damage": damage, "lust": lust, "pain": pain, "stamina": stamina}

func getResistAnimation():
	return "struggle_gag"

func getTightLockRequiredItemID() -> String:
	return "Shiv"

func getTightLockUnlockMessage() -> String:
	return "The lock is impossible to remove so you just cut through the leather straps of the head harness with a shiv, being careful as to not hurt yourself in the process."

func getForceOnCombatAnim() -> String:
	return "RestraintFace"
