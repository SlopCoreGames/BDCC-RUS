extends Attack

func _init():
	id = "LuxeIronGrip"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Железная хватка"
	
func getVisibleDesc(_context = {}):
	return "Shouldn't see this"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		addLuxeRage(_attacker, 0.25)
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		addLuxeRage(_attacker, 0.25)
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "Рука {attacker.name} смыкается на твоем горле, словно тиски, перекрывая воздух, пока {attacker.he} приподнимает тебя над землей. В глазах все плывет, когда хватка {attacker.his} сжимается еще сильнее, оставляя синяки на трахее, прежде чем {attacker.he} с силой впечатает тебя в землю."
	return {
		text = text,
		pain = 10,
		stamina = 15,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	var text = "Глаза {attacker.name} сужаются, когда {attacker.he} приближается, а кончики {attacker.his} начинают слабо светиться. Его когти напрягаются, готовые вцепиться в тебя."

	return text

func getRequirements():
	return [AttackRequirement.FreeArms]
	

func getAttackSoloAnimation():
	return "punch"

func getRecieverArmorScaling(_attacker, _receiver, _damageType) -> float:
	return 1.0

func addLuxeRage(_attacker, howMuch:float):
	if(_attacker.hasEffect("LuxeRage")):
		_attacker.getEffect("LuxeRage").addRage(howMuch)
