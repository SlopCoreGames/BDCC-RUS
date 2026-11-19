extends Attack

func _init():
	id = "MirriFlasher"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Вспышка"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	_attacker.addEffect("MirriRecharge", [2])
	
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "{attacker.name} сует вам в лицо {attacker.his} флашер и включает его. В глазах всё белеет, вы спотыкаетесь, окончательно дезориентированный."
	if(_receiver.addEffect("BlindnessAdvanced", [2])):
		text += " [b]Вы ослепли![/b]"
	
	return {
		text = text,
		#pain = 50,
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	if(_receiver.hasEffect("BlindnessAdvanced")):
		return false
	if(_attacker.hasEffect("MirriRecharge")):
		return false
	
	return true

func getAnticipationText(_attacker, _receiver):
	var text = "{attacker.name} достает {attacker.his} флашер."

	return text

func getRequirements():
	return [AttackRequirement.FreeArms]
	

#func getAttackSoloAnimation():
#	return ["firepistol", "res://Inventory/UnriggedModels/Pistol/Pistol.tscn"]

func getRecieverArmorScaling(_attacker, _receiver, _damageType) -> float:
	return 1.0

func getAttackSoloAnimation():
	return "punch"
