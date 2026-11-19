extends Attack

func _init():
	id = "LuxeBreatheInOut"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Вдох и выдох"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	var text = "{attacker.name} чувствует, как {attacker.his} грудь сдавливает. {attacker.He} использует {attacker.his} ход, чтобы закрыть {attacker.his} глаза и выровнять {attacker.his} дыхание."
	
	text += "\n\n"
	text += "[say=attacker]"+RNG.pick([
		"Я научилась это контролировать.",
		"Легкой прогулки тебе не будет.",
		"Я не сдохну из-за тебя.",
		]) + "[/say]"
	
	addLuxeRage(_attacker, -2.5)
	return {
		text = text,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	if(getLuxeRage(_attacker) < 1.5):
		return false
	
	return true

func canBeDodgedByPlayer(_attacker, _receiver):
	return false
	
func getRequirements():
	return [AttackRequirement.CanTalk]
	
func getRecieverArmorScaling(_attacker, _receiver, _damageType) -> float:
	return 1.0

func addLuxeRage(_attacker, howMuch:float):
	if(_attacker.hasEffect("LuxeRage")):
		_attacker.getEffect("LuxeRage").addRage(howMuch)

func getLuxeRage(_attacker) -> float:
	if(_attacker.hasEffect("LuxeRage")):
		return _attacker.getEffect("LuxeRage").rage
	return 0.0
