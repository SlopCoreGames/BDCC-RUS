extends Attack

func _init():
	id = "TaviTemptingTease"
	category = Category.Lust
	aiCategory = AICategory.Lust
	
func getVisibleName(_context = {}):
	return "Искушающая дразнилка"
	
func getVisibleDesc(_context = {}):
	return "Shouldn't see this"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(RNG.chance(50)):
		if(checkMissed(_attacker, _receiver, DamageType.Physical)):
			return genericMissMessage(_attacker, _receiver, "scratch")
		
		if(checkDodged(_attacker, _receiver, DamageType.Physical)):
			return genericDodgeMessage(_attacker, _receiver, "scratch")
		
		var text = "{attacker.name} своим соблазнительным танцем отвлекает {receiver.name}, оставляя брешь для молниеносной атаки {attacker.him}."
			
		return {
			text = text,
			lust = RNG.randi_range(5, 10),
			pain = RNG.randi_range(30, 40),
		}
	else:
		var text = "{attacker.name} соблазнительно выставляет себя напоказ, отвлекая {receiver.name}, что позволяет {attacker.him} тереться {attacker.his} телом о {receiver.name}."
			
		return {
			text = text,
			lust = RNG.randi_range(30, 40),
		}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	var text = "{attacker.name} ухмыляется и принимает провокационную позу, соблазняя {receiver.name} своим манящим телом {attacker.his}. Можно только гадать, что {attacker.he} выкинет дальше.."

	return text

func getRequirements():
	return [AttackRequirement.FreeArms]

func getAttackSoloAnimation():
	return "LustBodyAttack"
