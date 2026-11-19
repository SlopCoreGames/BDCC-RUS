extends RestraintData
class_name RestraintHypnovisor

func _init():
	npcDodgeDifficultyMod = 0.8
	restraintType = RestraintType.HypnoVisor

func canUnlockWithKey():
	return false
	
func alwaysSavedWhenStruggledOutOf():
	return true

func getLevelDamage():
	return .getLevelDamage() * 0.5

func shouldDoStruggleMinigame(_pc):
	if(HypnokinkUtil.isInTrance(_pc) && !_pc.hasPerk(Perk.HypnosisGoodAtVisors)):
		return false #cannot succeed
	if(HypnokinkUtil.isHypnotized(_pc)):
		return true
	if(_pc.hasBoundArms() || _pc.hasBlockedHands()):
		return true
		
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
	
	var inTrance = HypnokinkUtil.isInTrance(_pc)
	var hypnotized = HypnokinkUtil.isHypnotized(_pc)
	
	if(inTrance && RNG.chance(75) && not _pc.hasPerk(Perk.HypnosisGoodAtVisors) && !_minigame.beingHelped):
		text = "{user.name} пытается... попытаться... \n\nЧто сделать? Должно быть, это было не так уж важно."
		damage = 0.0
		return {"text": text, "damage": damage, "lust": lust, "pain": pain, "stamina": stamina}
	
	var damageMult = 1
	if(not hypnotized):
		damageMult = 5
	
	if(failChanceLowScore(_pc, 15, _minigame)):
		text = "{user.name} пытается стряхнуть гипновизор, но из-за панических движений {user.his} он [b]затягивается еще сильнее[/b] на голове у {user.his}. Мигающие огни и кружащиеся узоры становятся интенсивнее, еще глубже погружая {user.his} в транс."
		damage = -0.5
	elif(_handsFree and _armsFree):
		text = "{user.name} тянется вверх, пытаясь сосредоточиться на том, чтобы снять с {user.his} " + getItem().getVisibleName() + "."
		damage = calcDamage(_pc, _minigame, damageMult)
		stamina = 2
	elif(_handsFree):
		text = "Руки {user.name} свободны, но они связаны вместе, так что {user.name} приходится неуклюже наклоняться, чтобы дотянуться до {user.his} " + getItem().getVisibleName() + "."
		damage = calcDamage(_pc, _minigame, damageMult * 0.3)
		stamina = 5
	else:
		text = "{user.name} трясет головой {user.his}, пытаясь сбросить {user.his} " + getItem().getVisibleName() + "."
		damage = calcDamage(_pc, _minigame, damageMult * 0.1)
		stamina = 10
	
	return {"text": text, "damage": damage, "lust": lust, "pain": pain, "stamina": stamina}

func getResistAnimation():
	return "struggle_gag"

func processStruggleTurn(_pc, _isActivelyStruggling):
	var text = "ОШИБКА! По какой-то причине не был выбран текст для гипновизора"
	if(getItem().id == "HypnovisorMk0"):
		text = RNG.pick([
			"Pretty spiral..",
			"Need to be useful..",
			"{user.name} should keep {user.his} visor on, for {user.his} own safety..",
			"{user.name} wants to be a good {user.boy}..",
			"Must.. Obey?",
			"{user.name} struggles to look away from the flashing images.",
			"{user.name} struggles to look away from the spinning spiral.",
		])
	else:
		text = RNG.pick([
			"The lights are so colorful..",
			"Toy.. pet.. Toy.. pet..",
			"{user.name} wants to be a good pet..",
			"{user.name} wants to be a good toy..",
			"Colorful lights are so hypnotizing..",
			"Must.. Obey?",
			"{user.name} struggles to look away from the colorful lights.",
		])
		
	if(failChance(_pc, 30) || _isActivelyStruggling):
		return {"text": text, "lust": scaleDamage(5 + int(_isActivelyStruggling)*5)}

func getForceOnCombatAnim() -> String:
	return "RestraintEyes"
