extends RestraintData
class_name RestraintMittens

func _init():
	npcDodgeDifficultyMod = 1.2
	restraintType = RestraintType.Mittens
	sexReaction = SexReaction.BondageMittens

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
		text = "{user.name} изо всех сил пытается высунуть {user.his} руки из БДСМ-варежек, но {user.his} лихорадочные попытки лишь заставляют варежки [b]еще сильнее сжиматься вокруг {user.his} ладоней[/b], делая {user.his} пальцы совершенно бесполезными."
		damage = -0.5
	elif(_legsFree):
		text = "{user.name} наступает на варежки и пытается вытянуть из них {user.his} руки."
		damage = calcDamage(_pc, _minigame)
		stamina = 10
		
		if(failChance(_pc, 10)):
			text += " Ой, {user.name} случайно наступает на палец {user.his}."
			pain = scaleDamage(5)
	elif(_canBite && _armsFree):
		text = "{user.name} вгрызается в одну из варежек, пытаясь освободить {user.his} руку. Не самый эффективный метод, но лучше, чем ничего."
		damage = calcDamage(_pc, _minigame, 0.6)
		stamina = 10

		if(failChance(_pc, 10)):
			text += " Ой, {user.name} случайно прикусывает руку {user.his}."
			pain = scaleDamage(5)
	else:
		text = "{user.name} беспомощно пытается стряхнуть варежки, дрыгая ими."
		damage = calcDamage(_pc, _minigame, 0.4)
		stamina = RNG.randi_range(10, 20)
		
		if(failChance(_pc, 20)):
			text += " Ой! {user.name} случайно ударил ими о "+RNG.pick(["стену", "землю", "something"])
			pain = scaleDamage(RNG.randi_range(5, 10))
	
	return {"text": text, "damage": damage, "lust": lust, "pain": pain, "stamina": stamina}

func getTightLockRequiredItemID() -> String:
	return "Шило"

func getTightLockUnlockMessage() -> String:
	return "Замок невозможно снять, так что приходится уничтожать варежки. Ты садишься, зажимаешь заточку между ног и начинаешь кромсать ими кожу, медленно отрывая куски.\n\nВскоре тебе удается освободить руки!"

func getForceOnCombatAnim() -> String:
	return "RestraintHands"
