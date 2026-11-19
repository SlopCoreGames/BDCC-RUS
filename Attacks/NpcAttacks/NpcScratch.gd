extends Attack

func _init():
	id = "NpcScratch"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	
func getVisibleName(_context = {}):
	return "Царапанье"
	
func getVisibleDesc(_context = {}):
	return "Этого здесь быть не должно"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical)):
		return genericMissMessage(_attacker, _receiver)
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver)
	
	var text = "{attacker.name} вонзает {attacker.his} острые когти под кожу {receiver.name} и оставляет глубокую царапину!"
	
	if(RNG.chance(50) && _receiver.addEffect(StatusEffect.Bleeding)):
		text += " Острые когти заставили {receiver.name} начать [color=red]кровоточить[/color]."
	return {
		text = text,
		pain = RNG.randi_range(20, 40),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} вонзает {attacker.his} когти и пытается проткнуть {receiver.name}!"

func getAttackSoloAnimation():
	return "punch"

func getRequirements():
	return [AttackRequirement.FreeArms, AttackRequirement.FreeHands]
