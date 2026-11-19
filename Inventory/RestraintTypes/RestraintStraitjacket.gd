extends RestraintData
class_name RestraintStraitjacket

func _init():
	npcDodgeDifficultyMod = 1.5
	restraintType = RestraintType.Straitjacket
	
func resetOnNewDay():
	pass

func getLevelDamage():
	return 0.04 + 0.1 / level

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
	
	if(failChanceLowScore(_pc, 10, _minigame)):
		text = "{user.name} отчаянно извивается, пытаясь высвободить {user.his} руки из смирительной рубашки. Однако {user.his} лишь [b]делает её ещё теснее[/b], ремни впиваются в {user.his} кожу, ещё надежнее обездвиживая {user.his} руки."
		damage = -0.3
		stamina = RNG.randi_range(50, 60)
		pain = scaleDamage(10)
	else:
		text = "{user.name} беспомощно пытается выскользнуть из смирительной рубашки."
		damage = calcDamage(_pc, _minigame)
		stamina = RNG.randi_range(50, 60)
	
	return {"text": text, "damage": damage, "lust": lust, "pain": pain, "stamina": stamina}

func getForceOnCombatAnim() -> String:
	return "RestraintBody"
