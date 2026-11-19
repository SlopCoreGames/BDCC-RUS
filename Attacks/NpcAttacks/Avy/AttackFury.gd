extends Attack

func _init():
	id = "AttackFury"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Яростная атака"
	
func getVisibleDesc(_context = {}):
	return "Shouldn't see this"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		if(RNG.chance(50)):
			var text = "{receiver.name} уклоняется от удара, но молниеносные рефлексы {attacker.name} позволяют {attacker.her} всё равно поймать {receiver.name} и впечатать {receiver.him} в землю!"
			
			_receiver.addEffect(StatusEffect.Collapsed)
			return {
				text = text,
				pain = RNG.randi_range(5, 10),
			}
		
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "{attacker.name} с молниеносной скоростью бросается вперед, нанося серию мощных ударов по телу {receiver.name}."
	
	if(RNG.chance(30) && _receiver.addEffect(StatusEffect.Bleeding)):
		text += " Sharp claws caused {receiver.name} to start [color=red]bleeding[/color]."
	return {
		text = text,
		pain = RNG.randi_range(20, 40),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name}'s eyes narrow as {attacker.he} readies {attacker.his} devastating strike."

func getAttackSoloAnimation():
	return "charge"

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]
