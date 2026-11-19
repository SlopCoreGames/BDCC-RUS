extends RestraintData
class_name RestraintChastityCage

func _init():
	restraintType = RestraintType.ChastityCage
	sexReaction = SexReaction.BondageChastityCage

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
		text = "{user.name} дергает за девственную клетку, надеясь найти способ выскользнуть {user.his} члену наружу. Однако {user.his} действия лишь заставляют клетку [b]защелкнуться еще плотнее[/b], и металл неудобно впивается в {user.his} чувствительную кожу."
		damage = -0.5
	elif(_handsFree && _armsFree):
		text = "{user.name} дергает за {user.his} девственную клетку, пытаясь ее снять."
		damage = calcDamage(_pc, _minigame)
		stamina = 10
	else:
		text = "{user.name} отчаянно пытается стряхнуть {user.his} девственную клетку, но почти не продвигается."
		damage = calcDamage(_pc, _minigame, 0.1)
		stamina = 5
	
	if(_handsFree && _armsFree && failChance(_pc, 20)):
		text += " Touching {user.his} caged cock made {user.him} quite aroused."
		lust = scaleDamage(5)
	elif(failChance(_pc, 20)):
		text += " {user.He} accidentally pinched {user.his} balls. Ow."
		pain = scaleDamage(5)
	
	#damage = calcDamage()
	
	return {"text": text, "damage": damage, "lust": lust, "pain": pain, "stamina": stamina}

func getForceOnCombatAnim() -> String:
	return "RestraintCrotch"
