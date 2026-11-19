extends RestraintData
class_name RestraintMuzzle

func _init():
	restraintType = RestraintType.Muzzle
	sexReaction = SexReaction.BondageMuzzle

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
		text = "{user.name} отчаянно дергается в корзинчатой наморднике, пытаясь его стряхнуть. Но вместо этого движения {user.his} заставляют его [b] сильнее прижиматься[/b] к {user.his} лицу, а ремни еще крепче сдавливают {user.his} щеки и челюсть."
		damage = -0.5
	elif(_handsFree && _armsFree):
		text = "{user.name} тянет за ремни налобной портупеи {user.his}, пытаясь снять её."
		damage = calcDamage(_pc, _minigame)
		stamina = 10
	else:
		text = "{user.name} отчаянно пытается стянуть сбрую со {user.his} головы."
		damage = calcDamage(_pc, _minigame, 0.1)
		stamina = 5
	
		if(failChance(_pc, 40)):
			text += " Shaking {user.his} head so much makes {user.him} disoriented."
			pain = scaleDamage(5)
	
	return {"text": text, "damage": damage, "lust": lust, "pain": pain, "stamina": stamina}

func getResistAnimation():
	return "struggle_gag"

func getTightLockRequiredItemID() -> String:
	return "Shiv"

func getTightLockUnlockMessage() -> String:
	return "The lock is impossible to remove so you just cut through the leather straps that hold the muzzle on your face with a shiv, being careful as to not hurt yourself in the process."

func getForceOnCombatAnim() -> String:
	return "RestraintFace"
