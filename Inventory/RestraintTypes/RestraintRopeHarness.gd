extends RestraintData
class_name RestraintRopeHarness

func _init():
	restraintType = RestraintType.Harness

func canUnlockWithKey():
	return false

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
	
	if(failChanceLowScore(_pc, 20, _minigame)):
		text = "{user.name} извивается и дергается в веревках, но от {user.his} усилий [b]узлы затягиваются еще туже[/b]. Грубая веревка впивается в {user.his} кожу, оставляя синяки."
		damage = -0.5
		pain = scaleDamage(5)
	elif(_armsFree && _handsFree):
		text = "{user.name} пытается на ощупь найти узел, чтобы дернуть его"
		damage = calcDamage(_pc, _minigame)
		stamina = 10
		lust = scaleDamage(5)
	else:
		text = "{user.name} пытается стряхнуть с себя веревочную сбрую"
		damage = calcDamage(_pc, _minigame, 0.5)
		stamina = 10
		lust = scaleDamage(5)

	return {"text": text, "damage": damage, "lust": lust, "pain": pain, "stamina": stamina}

func processStruggleTurn(_pc, _isActivelyStruggling):
	if(failChance(_pc, 10) || _isActivelyStruggling):
		return {"text": RNG.pick(["веревочная сбруя {user.nameS} трется об один из {user.his} сосков", "веревочная сбруя {user.nameS} впивается в {user.his} промежность"]), "lust": scaleDamage(5)}

func getTightLockRequiredItemID() -> String:
	return "Шило"

func getTightLockUnlockMessage() -> String:
	return "Замок невозможно снять, поэтому тебе приходится использовать шило, чтобы перерезать веревки сбруи, медленно освобождаясь из ее объятий, пока ты наконец не сможешь просто вышагнуть из нее."

func getForceOnCombatAnim() -> String:
	return "RestraintBody"
