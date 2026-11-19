extends Attack

func _init():
	id = "LuxeTauntingSnarl"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Издевательский рык"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	var text = "{attacker.name} рычит, и его слова жалят, словно клинки."
	
	text += "\n\n"
	text += "[say=attacker]"+RNG.pick([
		"Сражайся со мной по-человечески, или ползай, как трус.",
		"Ты слабак.",
		"Тупой, слабый, расходный материал.",
		"И это всё, на что ты способен?",
		]) + "[/say]"
	
	addLuxeRage(_attacker, RNG.randf_rangeX2(0.2, 0.4))
	return {
		text = text,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	if(getLuxeRage(_attacker) > 0.5):
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

func getAttackSoloAnimation():
	return "TauntPoint"
