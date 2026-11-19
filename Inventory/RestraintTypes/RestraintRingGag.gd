extends "res://Inventory/RestraintTypes/RestraintMuzzle.gd"
class_name RestraintRingGag

func _init():
	restraintType = RestraintType.Gag
	sexReaction = SexReaction.BondageGag

func getResistAnimation():
	return "struggle_gag"

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
		text = "{user.name} изо всех сил пытается вытолкнуть кольцо-кляп изо рта {user.his}, но от {user.his} лихорадочных движений металлический обод лишь сильнее [b] впивается в {user.his} зубы и губы[/b], заставляя рот {user.his} всегда оставаться широко открытым."
		damage = -0.5
	elif(_handsFree && _armsFree):
		text = "{user.name} тянет за ремни налобной портупеи {user.his}, пытаясь снять её."
		damage = calcDamage(_pc, _minigame)
		stamina = 10
	else:
		text = "{user.name} пытается выплюнуть кольцо изо рта {user.his}, но это оказывается чертовски трудно."
		damage = calcDamage(_pc, _minigame, 0.1)
		stamina = 5
	
	if(failChance(_pc, 20)):
		text += " Из-за кольца {user.him} постоянно пускает слюни."
		lust = scaleDamage(5)
	
	#damage = calcDamage()
	
	return {"text": text, "damage": damage, "lust": lust, "pain": pain, "stamina": stamina}

func getTightLockRequiredItemID() -> String:
	return "Шило"

func getTightLockUnlockMessage() -> String:
	return "Замок невозможно снять, поэтому приходится просто перерезать кожаные ремни портупеи заточенным шилом, стараясь при этом не пораниться."

func getForceOnCombatAnim() -> String:
	return "RestraintFace"
