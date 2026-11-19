extends Attack

func _init():
	id = "BitePCAttack"
	category = Category.Physical
	aiCategory = AICategory.Offensive
	isPlayerAttack = true
	attackPriority = 20
	
func getVisibleName(_context = {}):
	return "Укус"
	
func getVisibleDesc(_context = {}):
	return "60% cшансов сделать "+scaledDmgRangeStr(DamageType.Physical, 15, 20)+" наносит урон и вызывает кровотечение.\n\nНевозможно промахнуться, если противник лежит на земле.\n\nОчень слабо против бронированных противников"
	
func _doAttack(_attacker, _receiver, _context = {}):
	if(checkMissed(_attacker, _receiver, DamageType.Physical, 0.6)):
		return genericMissMessage(_attacker, _receiver, "bite")
	
	if(checkDodged(_attacker, _receiver, DamageType.Physical)):
		return genericDodgeMessage(_attacker, _receiver, "bite")

	var texts = [
		"{attacker.name} bites {receiver.name}",
		"{attacker.name} набрасывается на {receiver.name} и впивается зубами в {receiver.his} шею"
	]
	var text = RNG.pick(texts)
	
	if(!_receiver.hasEffect(StatusEffect.Bleeding)):
		if(_attacker.hasPerk(Perk.SexBiter)):
			if(_receiver.addEffect(StatusEffect.Bleeding, [5])):
				text += " из-за чего у {receiver.him} начинается [color=red]кровотечение[/color]"
		else:
			if(_receiver.addEffect(StatusEffect.Bleeding)):
				text += " из-за чего у {receiver.him} начинается [color=red]кровотечение[/color]"
	
	return {
		text = text,
		pain = RNG.randi_range(15, 20),
	}
	
func _canUse(_attacker, _receiver, _context = {}):
	return true

func getRequirements():
	return [AttackRequirement.CanBite]

func getAnticipationText(_attacker, _receiver):
	return "{attacker.name} скалит {attacker.his} клыки и внезапно бросается на тебя!"

func getAttackSoloAnimation():
	return "bite"

func getExperience():
	return [[Skill.Combat, 10]]

func getRecieverArmorScaling(_attacker, _receiver, _damageType) -> float:
	if(_attacker.hasPerk(Perk.SexBiter)):
		return 4.0
	
	return 10.0
