extends RestraintData
class_name RestraintHandCuffs

var tightlockShiv:bool = false

func _init():
	restraintType = RestraintType.WristCuffs
	sexReaction = SexReaction.BondageWristCuffs

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
		text = "{user.name} тянет и дергает наручники, но {user.his} лишь заставляет металл [b]впиваться в {user.his} запястья сильнее[/b]; с каждой тщетной попыткой сбежать кандалы защелкиваются всё туже."
		damage = -0.5
		pain = scaleDamage(5)
	elif(_handsFree && _canBite):
		text = "{user.name} использует {user.his} руки и рот, пытаясь снять наручники, не отпирая замок."
		damage = calcDamage(_pc, _minigame)
		stamina = 10
		
		if(failChance(_pc, 20)):
			text += " {user.name} замечает, что {user.himself} вовсю пускает слюни."
			lust = scaleDamage(5)
	elif(_handsFree):
		text = "{user.name} не может использовать {user.his} рот, но {user.he} едва достает до наручников {user.his} руками. {user.name} тянет за стяжку, пытаясь соскользнуть из неё."
		damage = calcDamage(_pc, _minigame, 0.8)
		stamina = 10
	elif(_canBite):
		text = "{user.name} пытается вывертеться из наручников. Невозможность использовать руки — полный отстой, но использование {user.his} рта помогает {user.him} удерживать их на месте."
		damage = calcDamage(_pc, _minigame, 0.7)
		stamina = 10
		
		if(failChance(_pc, 40)):
			text += " {user.name} замечает, что {user.himself} вовсю пускает слюни."
			lust = scaleDamage(5)
	else:
		text = "{user.name} беспомощно пытается вывертеться из наручников."
		damage = calcDamage(_pc, _minigame, 0.5)
		stamina = RNG.randi_range(10, 20)
		
		if(failChance(_pc, 20)):
			text += " Ой! {user.name} случайно ударил ими о "+RNG.pick(["стену", "землю", "something"])
			pain = scaleDamage(RNG.randi_range(5, 10))
	
	return {"text": text, "damage": damage, "lust": lust, "pain": pain, "stamina": stamina}

func getTightLockRequiredItemID() -> String:
	if(tightlockShiv):
		return "Шило"
	return .getTightLockRequiredItemID()

func getTightLockUnlockMessage() -> String:
	if(tightlockShiv):
		return "Замок невозможно открыть, поэтому приходится использовать шило, чтобы медленно перерезать ремень и освободить запястья."
	return .getTightLockUnlockMessage()

func getForceOnCombatAnim() -> String:
	return "RestraintHands"
