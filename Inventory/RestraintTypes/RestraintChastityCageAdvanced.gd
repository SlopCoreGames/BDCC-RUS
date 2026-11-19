extends RestraintChastityCage

func canUnlockWithKey():
	return false
	
func alwaysSavedWhenStruggledOutOf():
	return true

#func getLevelDamage():
#	return .getLevelDamage() * 0.2

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
	
	if((_minigame.score < 0.7 || failChance(_pc, 10)) && !_minigame.instantUnlock):
		text = "{user.name}'а девственная клетка ПИЩИТ... И вдруг [b]бьет током[/b] {user.his} {user.penis}!"
		stamina = 0
		pain = RNG.randi_range(10, 20)
		damage = -0.3
	else:
		if(_handsFree && _armsFree):
			text = "{user.name} дергает за {user.his} девственную клетку, пытаясь ее снять."
			damage = calcDamage(_pc, _minigame)
			stamina = 10
		else:
			text = "{user.name} отчаянно пытается стряхнуть {user.his} девственную клетку, но почти не продвигается."
			damage = calcDamage(_pc, _minigame, 0.1)
			stamina = 5
		
		if(_handsFree && _armsFree && failChance(_pc, 20)):
			text += " Прикосновение к {user.his} зажатому в клетку члену привело {user.him} в состояние сильного возбуждения."
			lust = scaleDamage(5)
		elif(failChance(_pc, 20)):
			text += " {user.He} случайно прищелкнул {user.his} яйца. Ой!"
			pain = scaleDamage(5)
		
		if(failChance(_pc, 30)):
			text += " Дефлорационная клетка {user.name} ПИЩИТ... Но на этот раз с {user.him} ничего не происходит. Фух."
		
	#damage = calcDamage()
	
	return {"text": text, "damage": damage, "lust": lust, "pain": pain, "stamina": stamina}

func getForceOnCombatAnim() -> String:
	return "RestraintCrotch"
