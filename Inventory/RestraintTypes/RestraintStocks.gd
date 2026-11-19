extends RestraintData
class_name RestraintStocks

func resetOnNewDay():
	pass

func getVisibleTightness():
	if(tightness > 0.9):
		return "very sturdy"
	if(tightness > 0.8):
		return "sturdy"
	if(tightness > 0.7):
		return "sturdy enough"
	if(tightness > 0.6):
		return "gives in a little bit"
	if(tightness > 0.5):
		return "gives some leeway"
	if(tightness > 0.4):
		return "quite a bit of leeway"
	if(tightness > 0.3):
		return "kinda close to escaping"
	if(tightness > 0.2):
		return "close to escaping"
	if(tightness > 0.1):
		return "very close to escaping"
	return "you're almost free"

func getRemoveMessage():
	return "Stocks miraculously give in and let you free your arms and head"

func alwaysBreaksWhenStruggledOutOf():
	return true

func getLevelDamage():
	return 0.05

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
		text = "{user.name} пытается извиваться всем {user.his} телом, но одно неверное движение — и ты [b]потеряешь кучу прогресса[/b]!"
		damage = -0.3
		stamina = 70
	elif(_legsFree):
		text = "{user.name} извивается всем {user.his} телом, пытаясь вырваться."
		damage = calcDamage(_pc, _minigame)
		stamina = 70
	else:
		text = "{user.name} беспомощно извивается всем {user.his} телом, но из-за того, что {user.his}ноги скованы, это почти бесполезно."
		damage = calcDamage(_pc, _minigame, 0.5)
		stamina = RNG.randi_range(70, 90)
		
	if(luckChance(_pc, 1) && damage > 0.0):
		text += " {user.name} удалось освободить одну из рук {user.his}!"
		damage = max(0.5, damage)
	elif(failChance(_pc, 10)):
		text += " {user.name} отчаянно пытается взломать замки колодок, но лишь окончательно изматывает себя."
		stamina += 20
	
	return {"text": text, "damage": damage, "lust": lust, "pain": pain, "stamina": stamina}
